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
 * 课程信息：(CourseInformation)表实体类
 *
 */
@TableName("`course_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class CourseInformation implements Serializable {

    // CourseInformation编号
    @TableId(value = "course_information_id", type = IdType.AUTO)
    private Integer course_information_id;

    // 课程名称
    @TableField(value = "`course_name`")
    private String course_name;
    // 封面图片
    @TableField(value = "`cover_photo`")
    private String cover_photo;
    // 课程类型
    @TableField(value = "`course_type`")
    private String course_type;
    // 上课地点
    @TableField(value = "`class_location`")
    private String class_location;
    // 上课时间
    @TableField(value = "`class_time`")
    private String class_time;
    // 课程人数
    @TableField(value = "`number_of_courses`")
    private String number_of_courses;
    // 可选人数
    @TableField(value = "`number_of_people_available`")
    private Integer number_of_people_available;
    // 授课教师
    @TableField(value = "`lecturer`")
    private Integer lecturer;
    // 详情介绍
    @TableField(value = "`details`")
    private String details;

    // 点击数
    @TableField(value = "hits")
    private Integer hits;








    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
