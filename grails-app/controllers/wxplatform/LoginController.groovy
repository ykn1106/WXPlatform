package wxplatform

class LoginController {

    def doLogin = {
        def userInstance = User.findWhere(name:params.name, password: params.password)
        session.user = userInstance
        if(userInstance){
            redirect(controller: 'record', action: 'index')
        }else{
            redirect(controller: 'user', action: 'login', params:[errorMsg:"用户名或密码错误！"])
        }
    }

    def logOut = {
        session.user = null
        redirect(controller: 'user', action: 'login')
    }

}
