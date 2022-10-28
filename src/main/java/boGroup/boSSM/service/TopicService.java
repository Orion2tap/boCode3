package boGroup.boSSM.service;

import boGroup.boSSM.Utility;
import boGroup.boSSM.mapper.TopicMapper;
import boGroup.boSSM.model.BoardModel;
import boGroup.boSSM.model.TopicModel;
import boGroup.boSSM.model.UserModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Service
public class TopicService {
    TopicMapper mapper;

    public TopicService(TopicMapper mapper) {
        this.mapper = mapper;
    }

    @Transactional
    public TopicModel add(String title, String content, Integer userId, Integer boardId) {
        TopicModel m = new TopicModel();
        m.setContent(content);
        m.setUserId(userId);
        m.setTitle(title);
        m.setBoardId(boardId);
        m.setCreatedTime(System.currentTimeMillis());
        m.setUpdatedTime(System.currentTimeMillis());

        mapper.insert(m);
        return m;
    }

    @Transactional
    public void delete(Integer id) {
        mapper.delete(id);
    }

    @Transactional
    public void update(Integer id, Integer boardId, String title, String content) {
        TopicModel m = new TopicModel();
        m.setId(id);
        m.setTitle(title);
        m.setContent(content);
        m.setBoardId(boardId);
        m.setUpdatedTime(System.currentTimeMillis());

        mapper.update(m);
    }

    // userId ⇉ allCreatedTopics
    public  ArrayList<TopicModel> allCreatedTopics(Integer id) {
        return mapper.allCreatedTopics(id);
    }

    // userId ⇉ allCommentedTopics
    public  ArrayList<TopicModel> allCommentedTopics(Integer id) {
        return mapper.allCommentedTopics(id);
    }

    // userId ⇉ allStaredTopics
    public  ArrayList<TopicModel> allStaredTopics(Integer id) {
        return mapper.allStaredTopics(id);
    }

    // (userId, limit, offset) ⇉ pageCreatedTopics
    public  ArrayList<TopicModel> pageCreatedTopics(Integer id, Integer limit, Integer offset) {
        return mapper.pageCreatedTopics(id, limit, offset);
    }

    // (userId, limit, offset) ⇉ pageCommentedTopics
    public  ArrayList<TopicModel> pageCommentedTopics(Integer id, Integer limit, Integer offset) {
        return mapper.pageCommentedTopics(id, limit, offset);
    }

    // (userId, limit, offset) ⇉ pageStaredTopics
    public  ArrayList<TopicModel> pageStaredTopics(Integer id, Integer limit, Integer offset) {
        return mapper.pageStaredTopics(id, limit, offset);
    }

    // () ⇉ allTopics
    public ArrayList<TopicModel> allTopics() {
        return mapper.selectAll();
    }

    // (limit, offset) ⇉ pageTopics
    public ArrayList<TopicModel> pageTopics(Integer limit, Integer offset) {
        return mapper.pageTopics(limit, offset);
    }

    // (boardId, limit, offset) ⇉ pageTopicsByBoardId
    public ArrayList<TopicModel> pageTopicsByBoardId(Integer boardId, Integer limit, Integer offset) {
        return mapper.pageTopicsByBoardId(boardId, limit, offset);
    }

    // () ⇉ noReplyTopics
    public ArrayList<TopicModel> noReplyTopics() {
        return mapper.noReplyTopics();
    }

    // topicId ⇉ topic
    public  TopicModel findById(Integer id) {
        return mapper.selectOne(id);
    }

    // topicId ⇉ topic + topic.board
    public  TopicModel findByIdWithBoard(Integer id) {
        return mapper.selectOneWithBoard(id);
    }

    // topicId ⇉ topic + topic.user + topic.board
    public  TopicModel findByIdWithUserAndBoard(Integer id) {
        return mapper.selectOneWithUserAndBoard(id);
    }

    // topicId ⇉ topic + topic.comments
    public  TopicModel findByIdWithComments(Integer id) {
        return mapper.selectOneWithComments(id);
    }

    // topicId ⇉ topic + topic.comments + topic.comments.user
    public  TopicModel findByIdWithCommentsAndUser(Integer id) {
        return mapper.selectOneWithCommentsAndUser(id);
    }

    // (userId, topicId, staredTime) ⇉ () [star topic]
    public void star(Integer userId, Integer topicId){
        Long staredTime = System.currentTimeMillis();
        mapper.star(userId, topicId, staredTime);
    }

    // (userId, topicId) ⇉ () [unstar topic]
    public void unstar(Integer userId, Integer topicId){
        mapper.unstar(userId, topicId);
    }

    // (userId, topicId) ⇉ result [star check]
    public Integer starCheck(Integer userId, Integer topicId){
        return mapper.starCheck(userId, topicId);
    }

    // () ⇉ boards
    public ArrayList<BoardModel> allBoards() {
        return mapper.selectAllBoards();
    }

    // boardId ⇉ topics
    public ArrayList<TopicModel> allTopicsByBoardId (Integer id) {
        return mapper.allTopicsByBoardId(id);
    }
}
