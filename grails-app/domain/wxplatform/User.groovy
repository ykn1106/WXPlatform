package wxplatform

class User {

    String name
    String password

    static constraints = {
        name(nullable: false, maxSize: 8)
        password(nullable: false, maxSize: 8)
    }
}
