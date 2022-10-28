package boGroup.boSSM.model;

import java.util.ArrayList;

public class TopicModel extends BaseModel {
    private Integer id;
    private String content;
    private String title;
    private Integer userId;
    private Integer boardId;
    private Long createdTime;
    private Long updatedTime;
    private UserModel user;
    private BoardModel board;
    private ArrayList<TopicCommentModel> comments;

    // 以下属性不在 DB 表内, 需要时动态统计
    // 并在 xml 配置内实现 xxxModel 到 DB 查询结果的映射
    private Integer count;
    private String newReviewerAvatar;
    private TopicCommentModel latestComment;
    private Long staredTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getBoardId() {
        return boardId;
    }

    public void setBoardId(Integer boardId) {
        this.boardId = boardId;
    }

    public Long getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Long createdTime) {
        this.createdTime = createdTime;
    }

    public Long getUpdatedTime() {
        return updatedTime;
    }

    public void setUpdatedTime(Long updatedTime) {
        this.updatedTime = updatedTime;
    }

    public UserModel getUser() {
        return user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }

    public BoardModel getBoard() {
        return board;
    }

    public void setBoard(BoardModel board) {
        this.board = board;
    }

    public ArrayList<TopicCommentModel> getComments() {
        return comments;
    }

    public void setComments(ArrayList<TopicCommentModel> comments) {
        this.comments = comments;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public String getNewReviewerAvatar() {
        return newReviewerAvatar;
    }

    public void setNewReviewerAvatar(String newReviewerAvatar) {
        this.newReviewerAvatar = newReviewerAvatar;
    }

    public TopicCommentModel getLatestComment() {
        return latestComment;
    }

    public void setLatestComment(TopicCommentModel latestComment) {
        this.latestComment = latestComment;
    }

    public Long getStaredTime() {
        return staredTime;
    }

    public void setStaredTime(Long staredTime) {
        this.staredTime = staredTime;
    }
}
