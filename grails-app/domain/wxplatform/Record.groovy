package wxplatform

class Record {

    String name
    String account
    String password
    String type
    String isAuth
    String admin
    String appId
    String appIdSecret
    String purpose
    String testing
    String status
    Date lastUpdated

    static constraints = {
        name(nullable: false,unique: true)
        account(nullable: false)
        password(nullable: false)
        type(nullable: false)
        isAuth(nullable: false)
        admin(nullable: false)
        appId(nullable: false,unique: true)
        appIdSecret(nullable: false,unique: true)
        purpose(nullable: true)
        testing(nullable: true)
        status(nullable: false)
    }
}
