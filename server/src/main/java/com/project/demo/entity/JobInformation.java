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
 * 作业信息：(JobInformation)表实体类
 *
 */
@TableName("`job_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class JobInformation implements Serializable {

    // JobInformation编号
    @TableId(value = "job_information_id", type = IdType.AUTO)
    private Integer job_information_id;

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
    // 作业标题
    @TableField(value = "`job_title`")
    private String job_title;
    // 作业附件
    @TableField(value = "`operation_attachment`")
    private String operation_attachment;









    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
