<template>
    <div class="write-page-container">
        <el-form class="page-form" :model="form" :rules="formRules" ref="formRef" label-position="top">
            <div class="wirite-page" v-show="pageIndex==1">
                <el-form-item label="文章标题" prop="title">
                    <el-input v-model="form.title" clearable placeholder="请输入标题"></el-input>
                </el-form-item>
                <el-form-item label="文章首图URL" prop="firstPicture">
                    <el-input v-model="form.firstPicture" placeholder="文章首图，用于随机文章展示" style="width:600px;" clearable></el-input>
                    <div style="height:20px;width:100%;"></div>
                    <file-upload className="text-left" :showFileList="true" :style="uploadStyle" :limit="1"
                        :fileUrls="form.firstPicture" @change="coverUploadSuccess" class="upload-class"></file-upload>
                </el-form-item>
            </div>
            <div class="wirite-page" v-show="pageIndex==2">
                <el-form-item label="文章描述" prop="description" class="description"
                    style="min-height: calc(100vh - 150px)">
                    <mavon-editor v-model="form.description" @imgAdd="descriptionContentImgAdd" @imgDel="ContentImgDel"
                        ref="descriptionContent" style="min-height: calc(100vh - 180px);" />
                </el-form-item>
            </div>
            <div class="wirite-page" v-show="pageIndex==3" style="min-height: calc(100vh - 150px)">
                <el-form-item label="文章正文" prop="content">
                    <mavon-editor @imgAdd="mdContentImgAdd" ref="mdContent" v-model="form.content"
                        @imgDel="ContentImgDel" style="min-height: calc(100vh - 180px);" />
                </el-form-item>
            </div>
            <div class="wirite-page" v-show="pageIndex==4" style="width:50%;margin:0 auto;">
                <el-form-item label="分类" prop="cate" class="form-item-inline cate">
                    <el-select v-model="form.cate" placeholder="请选择分类（输入可添加新分类）" :allow-create="true" :filterable="true"
                        style="width: 100%;">
                        <el-option :label="item.name" :value="item.id" v-for="item in categoryList" :key="item.id">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="标签" prop="tagList" class="form-item-inline tagList">
                    <el-select v-model="form.tagList" placeholder="请选择标签（输入可添加新标签）" :allow-create="true"
                        :filterable="true" :multiple="true" style="width: 100%;">
                        <el-option :label="item.name" :value="item.id" v-for="item in tagList" :key="item.id">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="字数" prop="words" label-width="250" class="form-item-inline words">
                    <el-input-number v-model="form.words" placeholder="请输入文章字数（自动计算阅读时长）" type="number">
                    </el-input-number>
                </el-form-item>
                <el-form-item label="阅读时长(分钟)" prop="readTime" class="form-item-inline readTime">
                    <el-input-number v-model="form.readTime" placeholder="请输入阅读时长（可选）默认 Math.round(字数 / 200)"
                        type="number">
                    </el-input-number>
                </el-form-item>
                <el-form-item label="浏览次数" prop="views" class="form-item-inline views">
                    <el-input-number v-model="form.views" placeholder="请输入文章字数（可选）默认为 0" type="number">
                    </el-input-number>
                </el-form-item>

            </div>
        </el-form>
        <div class="btn-box">
            <el-button type="primary" icon="el-icon-arrow-left" @click="previousPage" :disabled="pageIndex==1">上一步
            </el-button>
            <el-button type="primary" style="margin-left: auto;" @click="dialogVisible=true" v-show="pageIndex==4">保存
            </el-button>
            <el-button type="primary" class="btn-right" @click="nextPage" :disabled="pageIndex==4">下一步<i
                    class="el-icon-arrow-right el-icon--right"></i></el-button>
        </div>
        <el-backtop style="z-index:99999;border: 1px solid;">
            <i class="el-icon-arrow-up"></i>
        </el-backtop>

        <!--编辑可见性状态对话框-->
        <el-dialog title="博客可见性" width="30%" :visible.sync="dialogVisible">
            <!--内容主体-->
            <el-form label-width="50px" @submit.native.prevent>
                <el-form-item>
                    <el-radio-group v-model="radio">
                        <el-radio :label="1">公开</el-radio>
                        <el-radio :label="2">私密</el-radio>
                        <el-radio :label="3">密码保护</el-radio>
                    </el-radio-group>
                </el-form-item>
                <el-form-item label="密码" v-if="radio===3">
                    <el-input v-model="form.password"></el-input>
                </el-form-item>
                <el-form-item v-if="radio!==2">
                    <el-row>
                        <el-col :span="6">
                            <el-switch v-model="form.appreciation" active-text="赞赏"></el-switch>
                        </el-col>
                        <el-col :span="6">
                            <el-switch v-model="form.recommend" active-text="推荐"></el-switch>
                        </el-col>
                        <el-col :span="6">
                            <el-switch v-model="form.commentEnabled" active-text="评论"></el-switch>
                        </el-col>
                        <el-col :span="6">
                            <el-switch v-model="form.top" active-text="置顶"></el-switch>
                        </el-col>
                    </el-row>
                </el-form-item>
            </el-form>
            <!--底部-->
            <span slot="footer">
                <el-button @click="dialogVisible=false">取 消</el-button>
                <el-button type="primary" @click="submit">保存</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
import Breadcrumb from "@/components/Breadcrumb";
import fileUpload from "@/components/upload/file-upload";
import { removeHTMLTag } from "../../../util/utils";

import {
    getCategoryAndTag,
    saveBlog,
    getBlogById,
    updateBlog,
} from "@/api/blog";

export default {
    name: "WriteBlog",
    components: { Breadcrumb, fileUpload },
    data() {
        return {
            uploadStyle: {
                "text-align": "center",
            },
            pageIndex: 1,
            categoryList: [],
            tagList: [],
            dialogVisible: false,
            radio: 1,
            form: {
                title: "",
                firstPicture: "",
                description: "",
                content: "",
                cate: null,
                tagList: [],
                words: null,
                readTime: null,
                views: 0,
                appreciation: true,
                recommend: false,
                commentEnabled: true,
                top: false,
                published: true,
                password: "",
            },
            formRules: {
                title: [
                    {
                        required: true,
                        message: "请输入标题",
                        trigger: "change",
                    },
                ],
                firstPicture: [
                    {
                        required: true,
                        message: "请输入首图链接",
                        trigger: "change",
                    },
                ],
                cate: [
                    {
                        required: true,
                        message: "请选择分类",
                        trigger: "change",
                    },
                ],
                tagList: [
                    {
                        required: true,
                        message: "请选择标签",
                        trigger: "change",
                    },
                ],
                words: [
                    {
                        required: true,
                        message: "请输入文章字数",
                        trigger: "change",
                    },
                ],
            },
        };
    },
    watch: {
        "form.words"(newValue) {
            this.form.readTime = newValue ? Math.round(newValue / 200) : null;
        },
    },
    created() {
        this.getData();
        if (this.$route.params.id) {
            this.getBlog(this.$route.params.id);
        }
    },
    methods: {
        coverUploadSuccess(urls) {
            this.form.firstPicture = urls;
        },
        // 上一步
        previousPage() {
            this.pageIndex--;
            if (this.pageIndex < 1) {
                this.pageIndex = 1;
            }
        },
        // 下一步
        nextPage() {
            this.pageIndex++;
            if (this.pageIndex >= 4) {
                this.pageIndex = 4;
                var text = removeHTMLTag(this.form.content);
                if (text) {
                    this.form.words = text.length;
                }
            }
        },
        // 描述-图片上传回调
        descriptionContentImgAdd(pos, file) {
            let imgData = new FormData();
            imgData.append("file", file);
            this.$http.post("file/qiniu/upload", imgData).then((res) => {
                console.log("res.data", res.data);
                this.$refs.descriptionContent.$img2Url(pos, res.data);
            });
        },
        // 图片删除回调
        ContentImgDel(pos) {
            this.$http
                .post("file/qiniu/del", { url: pos[0] })
                .then((resp) => {});
        },
        // 正文-图片上传回调
        mdContentImgAdd(pos, file) {
            let imgData = new FormData();
            imgData.append("file", file);
            this.$http.post("file/qiniu/upload", imgData).then((res) => {
                this.$refs.mdContent.$img2Url(pos, res.data);
            });
        },
        getData() {
            getCategoryAndTag().then((res) => {
                this.categoryList = res.data.categories;
                this.tagList = res.data.tags;
            });
        },
        getBlog(id) {
            getBlogById(id).then((res) => {
                this.computeCategoryAndTag(res.data);
                this.form = res.data;
                this.radio = this.form.published
                    ? this.form.password !== ""
                        ? 3
                        : 1
                    : 2;
            });
        },
        computeCategoryAndTag(blog) {
            blog.cate = blog.category.id;
            blog.tagList = [];
            blog.tags.forEach((item) => {
                blog.tagList.push(item.id);
            });
        },
        submit() {
            if (
                this.radio === 3 &&
                (this.form.password === "" || this.form.password === null)
            ) {
                return this.msgError("密码保护模式必须填写密码！");
            }
            this.$refs.formRef.validate((valid) => {
                if (valid) {
                    if (this.radio === 2) {
                        this.form.appreciation = false;
                        this.form.recommend = false;
                        this.form.commentEnabled = false;
                        this.form.top = false;
                        this.form.published = false;
                    } else {
                        this.form.published = true;
                    }
                    if (this.radio !== 3) {
                        this.form.password = "";
                    }
                    if (this.$route.params.id) {
                        this.form.category = null;
                        this.form.tags = null;
                        updateBlog(this.form).then((res) => {
                            this.msgSuccess(res.msg);
                            this.$router.push("/blog/list");
                        });
                    } else {
                        saveBlog(this.form).then((res) => {
                            this.msgSuccess(res.msg);
                            this.$router.push("/blog/list");
                        });
                    }
                } else {
                    this.dialogVisible = false;
                    return this.msgError("请填写必要的表单项");
                }
            });
        },
    },
};
</script>

<style scoped>
.write-page-container {
    position: relative;
    min-height: calc(100vh - 80px);
}
.write-page-container .page-form,
.wirite-page {
    min-height: calc(100vh - 150px);
}
.btn-box {
    /* position: absolute; */
    bottom: 0;
    display: flex;
    width: 100%;
}
.btn-right {
    margin-left: auto;
}
</style>
<style>
.tagList .el-form-item__label,
.cate .el-form-item__label,
.words .el-form-item__label,
.readTime .el-form-item__label,
.views .el-form-item__label {
    width: 100px;
}
.tagList .el-form-item__content,
.cate .el-form-item__content {
    width: 250px;
}
</style>