package wxplatform

import grails.converters.JSON

class RecordController {

    //拦截器
//    def beforeInterceptor = [action:  this.&auth]

    def index(){
        def records = Record.findAll()
        def flag = (session.user)?"true":"false"
        render(view: "/record/index", model: [flag:flag, records: records  as JSON])
    }

    def doSave = {
        def result = [success:false, message:"公众号记录保存失败"];
        def log = ""
        try {
            if(params.id !=null && params.id !=""){
                Record sRecord = Record.get(params.id)
                if(sRecord){
                    def now = new Date()
                    result.success = true
                    if(sRecord.purpose != params.purpose || sRecord.status != params.status){
                        def res = Record.executeUpdate("update Record b set b.purpose=:newPurpose,b.status=:newStatus,b.lastUpdated=:newDate where b.id=${params.id}",[newPurpose: params.purpose,newStatus:params.status,newDate: now])
                        if(res !=null && res !=""){
                            sRecord.refresh()
                            log =   "<span style='color:blue'>更新操作:</span>"+"["+sRecord.name+"]"+"的当前用途为："+sRecord.purpose+";当前状态为："+deCodeStatus(sRecord.status)+";操作者："+session.user.name+";操作时间："+sRecord.lastUpdated+"</br>"
                        }else{
                            result.success = false
                        }
                    }
                }
            }else{
                Record newRecord = new Record(params)
                if(newRecord.save()){
                    log =   "<span style='color:green'>新增操作:</span>"+"新增"+"["+newRecord.name+"]公众号;"+"["+newRecord.name+"]"+"的当前用途为："+newRecord.purpose+";当前状态为："+deCodeStatus(newRecord.status)+";操作者："+session.user.name+";操作时间："+newRecord.lastUpdated+"</br>"
                    result.success = true
                }
            }
            if(result.success) {
                result.message = "公众号记录保存成功"
                result.item = Record.findAll()
                if(log) new Oplog(log: log).save()
            }
        }catch(Exception e){
            result.success = false
            result.message = e
        } finally{
            render(contentType: 'application/json'){
                result
            }
        }
    }

    def doDel = {
        def result=[success: false, message:"删除失败"]
        def log
        try {
            Record tRecord = Record.get(params.id)
            if(tRecord){
                log = "<span style='color:red'>删除操作:</span>"+"删除["+tRecord.name+"]公众号;"+";操作者："+session.user.name+";操作时间："+tRecord.lastUpdated+"</br>"
                tRecord.delete(flush: true)
                result.success = true
                result.message = "删除成功"
                result.item = Record.findAll()
                new Oplog(log: log).save()
            }
        }catch (Exception e){
            result.message = e
        }finally{
            render(contentType: 'application/json'){
                result
            }
        }
    }

    def search = {
        def result = null
        if(params.key != "" && params.key != null){
            result = Record.executeQuery("from Record where name like :key " +
                    "or admin like :key " +
                    "or purpose like :key ", [key: '%'+params.key+'%'])
        }else{
            result = Record.findAll()
        }
        render(contentType: 'application/json'){
            result
        }
    }

    private auth(){
        if(!session.user){
            redirect(controller: "user", action: "login")
        }
    }

    private String deCodeStatus(code){
        switch (code){
            case "0": return "离线"
            case "1": return "在线"
            case "2": return "未知"
            default:break
        }
    }
}
