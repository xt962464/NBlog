<template>
    <div>
        <el-form :model="form" label-position="top">
            <el-form-item label="动态内容" prop="content">
                <mavon-editor v-model="form.content" @imgAdd="mdContentImgAdd" @imgDel="ContentImgDel" ref="mdContent"
                    style="min-height: calc(100vh - 180px);" />
            </el-form-item>

            <el-form-item label="点赞数" prop="likes" style="width: 50%">
                <el-input-number v-model="form.likes" type="number" placeholder="可选，默认为 0"></el-input-number>
            </el-form-item>

            <el-form-item label="创建时间" prop="createTime">
                <el-date-picker v-model="form.createTime" type="datetime" placeholder="可选，默认此刻" :editable="false">
                </el-date-picker>
            </el-form-item>

            <el-form-item style="text-align: right;">
                <el-button type="info" @click="submit(false)">仅自己可见</el-button>
                <el-button type="primary" @click="submit(true)">发布动态</el-button>
            </el-form-item>
        </el-form>
    </div>
</template>

<script>
import Breadcrumb from "@/components/Breadcrumb";
import { getMomentById, saveMoment, updateMoment } from "@/api/moment";

export default {
    name: "WriteMoment",
    components: { Breadcrumb },
    data() {
        return {
            form: {
                content: "",
                createTime: null,
                likes: 0,
                published: false,
            },
        };
    },
    created() {
        if (this.$route.params.id) {
            this.getMoment(this.$route.params.id);
        }
    },
    methods: {
        // 正文-图片上传回调
        mdContentImgAdd(pos, file) {
            let imgData = new FormData();
            imgData.append("file", file);
            this.$http.post("file/qiniu/upload", imgData).then((res) => {
                this.$refs.mdContent.$img2Url(pos, res.data);
            });
        },
                // 图片删除回调
        ContentImgDel(pos) {
            this.$http
                .post("file/qiniu/del", { url: pos[0] })
                .then((resp) => {});
        },
        getMoment(id) {
            getMomentById(id).then((res) => {
                this.form = res.data;
            });
        },
        submit(published) {
            this.form.published = published;
            if (this.$route.params.id) {
                updateMoment(this.form).then((res) => {
                    this.msgSuccess(res.msg);
                    this.$router.push("/blog/moment/list");
                });
            } else {
                saveMoment(this.form).then((res) => {
                    this.msgSuccess(res.msg);
                    this.$router.push("/blog/moment/list");
                });
            }
        },
    },
};
</script>

<style scoped>
</style>