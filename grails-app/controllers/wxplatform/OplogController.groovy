package wxplatform

class OplogController {

    def index() { }

    def list ={
        def ops = Oplog.findAll()
        render(contentType: 'application/json'){
            ops
        }
    }
}
