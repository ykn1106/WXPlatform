import grails.util.Environment
import wxplatform.Record
import wxplatform.User

class BootStrap {

    def init = { servletContext ->
        //create default record under non-prod mode
        if (Environment.current == Environment.DEVELOPMENT || Environment.current == Environment.TEST) {
            log.info("===============当前处于开发或者TEST阶段==================");
            new Record(
                    name:"图谱微招聘1",
                    account: "3160810989@qq.com",
                    password: "198879wtf",
                    type: "服务号",
                    isAuth: "1",
                    appId: "wxd75e268a861e1b69",
                    appIdSecret: "46b586ea8fe27064f3477c0ccad92ce1",
                    admin: "王建华",
                    purpose: "迪皮埃",
                    testing: "wxviewbeta1.tupu360.com",
                    status: "1"
            ).save()
        }

        //create default user
        final String BACK_ADMIN='admin'
        if(!User.findByName(BACK_ADMIN)){
            new User(name:BACK_ADMIN,password:'tupu123').save()
        }
    }
    def destroy = {
    }
}
