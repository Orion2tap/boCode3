package boGroup.boSSM.aspect;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.METHOD)               // 该自定义的注解可以用在方法上
@Retention(RetentionPolicy.RUNTIME)     // 注解将在运行期保留
public @interface LoginRequired {
}
