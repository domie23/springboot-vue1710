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
 * 选课信息：(CourseSelectionInformation)表实体类
 *
 */
@TableName("`course_selection_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class CourseSelectionInformation implements Serializable {

    // CourseSelectionInformation编号
    @TableId(value = "course_selection_information_id", type = IdType.AUTO)
    private Integer course_selection_information_id;

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
    // 选课人数
    @TableField(value = "`number_of_participants`")
    private String number_of_participants;
    // 备注信息
    @TableField(value = "`remarks`")
    private String remarks;
    // 选课编号
    @TableField(value = "`course_no`")
    private String course_no;









    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
