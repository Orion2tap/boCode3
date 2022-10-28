package boGroup.boSSM.mapper;

import boGroup.boSSM.model.BoardModel;
import boGroup.boSSM.model.TopicCommentModel;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

// Spring-Boot 在 controller 进行依赖注入
@Repository
// MyBatis-Spring-Boot 将该接口与对应 xml 文件建立映射, 并注入到 session
@Mapper
public interface TopicCommentMapper {

    void insert(TopicCommentModel m);

    void delete(Integer id);

    void update(TopicCommentModel m);

    // commentId ⇉ comment
    TopicCommentModel selectOne(Integer id);

    // topicId ⇉ latestComment
    TopicCommentModel latestComment(Integer topicId);

    // () ⇉ comments
    ArrayList<TopicCommentModel> selectAll();

    // topicId ⇉ comments + comments.user
    ArrayList<TopicCommentModel> selectAllByTopicId(Integer id);



}
