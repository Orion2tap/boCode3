package boGroup.boSSM.service;

import boGroup.boSSM.Utility;
import boGroup.boSSM.mapper.TopicCommentMapper;
import boGroup.boSSM.mapper.TopicMapper;
import boGroup.boSSM.model.TopicCommentModel;
import boGroup.boSSM.model.TopicModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;

@Service
public class TopicCommentService {
    TopicCommentMapper topicCommentMapper;
    TopicMapper topicMapper;

    public TopicCommentService(TopicCommentMapper topicCommentMapper, TopicMapper topicMapper) {
        // 依赖注入
        this.topicCommentMapper = topicCommentMapper;
        this.topicMapper = topicMapper;
    }

    @Transactional
    public TopicCommentModel add(String content, String topicId, Integer userId) {
        TopicCommentModel m = new TopicCommentModel();
        TopicCommentModel lc = topicCommentMapper.latestComment(Integer.valueOf(topicId));

        m.setContent(content);
        m.setTopicId(Integer.valueOf(topicId));
        m.setUserId(userId);
        m.setCreatedTime(System.currentTimeMillis());
        m.setUpdatedTime(System.currentTimeMillis());
        // 假删除可实现正确显示楼层数
        m.setFloor((lc == null) ? 1 : lc.getFloor() + 1);

        topicCommentMapper.insert(m);
        return m;
    }

    @Transactional
    public void delete(Integer id) {
        topicCommentMapper.delete(id);
    }

    @Transactional
    public void update(Integer id, String content) {
        TopicCommentModel m = new TopicCommentModel();
        m.setId(id);
        m.setContent(content);
        m.setUpdatedTime(System.currentTimeMillis());

        topicCommentMapper.update(m);
    }

    // commentId ⇉ comment
    public TopicCommentModel findById(Integer id) {
        return topicCommentMapper.selectOne(id);
    }

    // topicId ⇉ comments + comments.user
    public ArrayList<TopicCommentModel> findCommentsByTopicId(Integer id) {
        return topicCommentMapper.selectAllByTopicId(id);
    }

}
