package com.project.demo.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * 课堂签到：(ClassSignIn)表实体类
 *
 */
@TableName("`class_sign_in`")
@Data
@EqualsAndHashCode(callSuper = false)
public class ClassSignIn implements Serializable {

    // ClassSignIn编号
    @TableId(value = "class_sign_in_id", type = IdType.AUTO)
    private Integer class_sign_in_id;

    // 课程名称
    @TableField(value = "`course_name`")
    private String course_name;
    // 授课教师
    @TableField(value = "`lecturer`")
    private Integer lecturer;
    // 学生用户
    @TableField(value = "`student_users`")
    private Integer student_users;
    // 学生姓名
    @TableField(value = "`student_name`")
    private String student_name;
    // 签到时间
    @TableField(value = "`sign_in_time`")
    private Timestamp sign_in_time;
    // 备注详情
    @TableField(value = "`note_details`")
    private String note_details;









    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
