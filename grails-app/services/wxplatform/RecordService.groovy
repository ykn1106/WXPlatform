package wxplatform

import grails.transaction.Transactional

@Transactional
class RecordService {

    def getStaticRecord(){
        return new Record(
                name:"图谱微招聘",
                account: "3160810989@qq.com",
                passowrd: "198879wtf",
                type: "服务号",
                isAuth: true,
                appId: "wxd75e268a861e1b69",
                appIdSecret: "46b586ea8fe27064f3477c0ccad92ce1",
                admin: "王建华",
                purpose: "迪皮埃",
                status: true
        )
    }

    def serviceMethod() {

    }
}
