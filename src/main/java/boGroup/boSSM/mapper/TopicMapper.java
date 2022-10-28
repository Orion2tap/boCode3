package boGroup.boSSM.mapper;

import boGroup.boSSM.model.BoardModel;
import boGroup.boSSM.model.TopicModel;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

// Spring-Boot 在 controller 进行依赖注入
@Repository
// MyBatis-Spring-Boot 将该接口与对应 xml 文件建立映射, 并注入到 session
@Mapper
public interface TopicMapper {
    void insert(TopicModel m);

    void delete(Integer id);

    void update(TopicModel m);

    // userId ⇉ allCreatedTopics
    ArrayList<TopicModel> allCreatedTopics(Integer userId);

    // userId ⇉ allCommentedTopics
    ArrayList<TopicModel> allCommentedTopics(Integer userId);

    // userId ⇉ allStaredTopics
    ArrayList<TopicModel> allStaredTopics(Integer userId);

    // (userId, limit, offset) ⇉ pageCreatedTopics
    ArrayList<TopicModel> pageCreatedTopics(@Param("userId") Integer userId, @Param("limit") Integer limit, @Param("offset") Integer offset);

    // (userId, limit, offset) ⇉ pageCommentedTopics
    ArrayList<TopicModel> pageCommentedTopics(@Param("userId") Integer userId, @Param("limit") Integer limit, @Param("offset") Integer offset);

    // (userId, limit, offset) ⇉ pageStaredTopics
    ArrayList<TopicModel> pageStaredTopics(@Param("userId") Integer userId, @Param("limit") Integer limit, @Param("offset") Integer offset);

    // () ⇉ allTopics
    ArrayList<TopicModel> selectAll();

    // (limit, offset) ⇉ pageTopics
    ArrayList<TopicModel> pageTopics(@Param("limit") Integer limit, @Param("offset") Integer offset);

    // (boardId, limit, offset) ⇉ pageTopicsByBoardId
    ArrayList<TopicModel> pageTopicsByBoardId(@Param("boardId") Integer boardId, @Param("limit") Integer limit, @Param("offset") Integer offset);

    // () ⇉ noReplyTopics
    ArrayList<TopicModel> noReplyTopics();

    // topicId ⇉ topic
    TopicModel selectOne(Integer id);

    // topicId ⇉ topic + topic.board
    TopicModel selectOneWithBoard(Integer id);

    // topicId ⇉ topic + topic.user + topic.board
    TopicModel selectOneWithUserAndBoard(Integer id);

    // topicId ⇉ topic + topic.comments
    TopicModel selectOneWithComments(Integer id);

    // topicId ⇉ topic + topic.comments + topic.comments.user
    TopicModel selectOneWithCommentsAndUser(Integer id);

    // (userId, topicId, staredTime) ⇉ () [star topic]
    void star(@Param("userId") Integer userId, @Param("topicId") Integer topicId, @Param("staredTime") Long staredTime);

    // (userId, topicId) ⇉ () [unstar topic]
    void unstar(@Param("userId") Integer userId, @Param("topicId") Integer topicId);

    // (userId, topicId) ⇉ result [star check]
    Integer starCheck(@Param("userId") Integer userId, @Param("topicId") Integer topicId);

    // () ⇉ boards
    ArrayList<BoardModel> selectAllBoards();

    // boardId ⇉ topics
    ArrayList<TopicModel> allTopicsByBoardId(Integer id);

}
