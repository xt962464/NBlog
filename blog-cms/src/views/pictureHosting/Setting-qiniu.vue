<template>
    <div class="qiniu-setting-form" v-loading="loadInd">
        <el-row class="form-btn">
            <el-button type="primary" :loading="saveLoading" @click="saveInfo">保存</el-button>
        </el-row>
        <div class="form-item">
            <el-form :model="settingJson" :rules="dataRule" ref="settingJson" label-width="100px">
                <el-form-item label="空间名称 : " prop="name">
                    <el-input v-model="settingJson.name" placeholder="空间名称"></el-input>
                </el-form-item>
                <el-form-item label="存储区域 : " prop="region">
                    <el-input v-model="settingJson.region" placeholder="存储区域"></el-input>
                </el-form-item>
                <el-form-item label="AK : " prop="ak">
                    <el-input v-model="settingJson.ak" placeholder="AK"></el-input>
                </el-form-item>
                <el-form-item label="SK : " prop="sk">
                    <el-input v-model="settingJson.sk" placeholder="SK"></el-input>
                </el-form-item>
                <el-form-item label="域名 : " prop="doMain">
                    <el-input v-model="settingJson.doMain" placeholder="cdn域名"></el-input>
                </el-form-item>
            </el-form>
        </div>
    </div>
</template>

<script>
import { getUserInfo } from "@/api/github";
import { getSettingByName, update } from "@/api/siteSetting";

export default {
    name: "Setting",
    data() {
        return {
            loadInd: false,
            saveLoading: false,
            settingKey: "qiniu",
            token: "",
            userInfo: {
                login: "未配置",
            },
            isSave: true,
            hintShow: false,
            setting: {
                nameEn: "qiniu",
                nameZh: "七牛云配置",
                value: "",
                type: 4,
            },
            settingJson: {
                name: "",
                region: "",
                ak: "",
                sk: "",
                doMain: "",
            },
        };
    },
    computed: {
        // 表单校验
        dataRule() {
            return {
                name: [
                    {
                        required: true,
                        message: "请输入空间名称",
                        trigger: "blur",
                    },
                ],
                region: [
                    {
                        required: true,
                        message: "请输入存储区域",
                        trigger: "blur",
                    },
                ],
                //AK
                ak: [{ required: true, message: "请输入AK", trigger: "blur" }],
                sk: [{ required: true, message: "请输入SK", trigger: "blur" }],
                doMain: [
                    {
                        required: true,
                        message: "请选择cdn域名",
                        trigger: "blur",
                    },
                ],
            };
        },
    },
    created() {
        this.getQiniuInfo();
        const userJson = window.localStorage.getItem("user") || "{}";
        const user = JSON.parse(userJson);
        if (userJson !== "{}" && user.role !== "ROLE_admin") {
            //对于访客模式，增加个提示
            this.hintShow = true;
        }
    },
    methods: {
        // 获取七牛云配置
        getQiniuInfo() {
            this.loadInd = true;
            getSettingByName({ name: this.settingKey }).then((res) => {
                if (
                    res.data[this.settingKey] &&
                    res.data[this.settingKey].length > 0
                ) {
                    this.setting = res.data[this.settingKey][0];
                    this.settingJson = JSON.parse(this.setting["value"]);
                }
                this.loadInd = false;
            });
        },
        // 更新
        saveInfo() {
            this.setting["value"] = JSON.stringify(this.settingJson);
            this.saveLoading = true;
            update([this.setting], [])
                .then((resp) => {
                    this.saveLoading = false;
                    this.$message({
                        message: "保存成功",
                        type: "success",
                    });
                })
                .catch((err) => {
                    this.saveLoading = false;
                });
        },
    },
};
</script>

<style>
.el-alert + .el-row,
.el-row + .el-row {
    margin-top: 20px;
}

.el-avatar {
    vertical-align: middle;
    margin-right: 15px;
}

.middle {
    vertical-align: middle;
}
</style>
<style scoped>
.qiniu-setting-form {
    margin: 0 auto;
    margin-top: 100px;
    width: 50%;
}
.form-btn {
    text-align: right;
    margin-bottom: 10px;
}
.form-item {
    border: 1px solid #e8e8e8;
    padding: 10px;
}
</style>