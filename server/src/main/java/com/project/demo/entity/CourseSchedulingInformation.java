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
 * 排课信息：(CourseSchedulingInformation)表实体类
 *
 */
@TableName("`course_scheduling_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class CourseSchedulingInformation implements Serializable {

    // CourseSchedulingInformation编号
    @TableId(value = "course_scheduling_information_id", type = IdType.AUTO)
    private Integer course_scheduling_information_id;

    // 授课教师
    @TableField(value = "`lecturer`")
    private Integer lecturer;
    // 教师姓名
    @TableField(value = "`teachers_name`")
    private String teachers_name;
    // 课程名称
    @TableField(value = "`course_name`")
    private String course_name;
    // 上课周数
    @TableField(value = "`class_weeks`")
    private String class_weeks;
    // 上课时间
    @TableField(value = "`class_time`")
    private String class_time;
    // 备注信息
    @TableField(value = "`remarks`")
    private String remarks;









    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
