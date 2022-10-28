package boGroup.boSSM.model;

public class UserModel extends BaseModel {
    private Integer id;
    private String username;
    private String password;
    private UserRole role;
    private String email;
    private String registrationTime;
    private String avatar;
    private String site;
    private String location;
    private String github;
    private String note;

    // 以下属性不在 DB 表内, 需要时动态统计
    // 并在 xml 配置内实现 xxxModel 到 DB 查询结果的映射
    private Integer score;
    private Integer createdTopicsCount;
    private Integer createdCommentsCount;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRegistrationTime() {
        return registrationTime;
    }

    public void setRegistrationTime(String registrationTime) {
        this.registrationTime = registrationTime;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getGithub() {
        return github;
    }

    public void setGithub(String github) {
        this.github = github;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public Integer getCreatedTopicsCount() {
        return createdTopicsCount;
    }

    public void setCreatedTopicsCount(Integer createdTopicsCount) {
        this.createdTopicsCount = createdTopicsCount;
    }

    public Integer getCreatedCommentsCount() {
        return createdCommentsCount;
    }

    public void setCreatedCommentsCount(Integer createdCommentsCount) {
        this.createdCommentsCount = createdCommentsCount;
    }
}

