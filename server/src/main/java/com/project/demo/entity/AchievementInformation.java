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
 * 成绩信息：(AchievementInformation)表实体类
 *
 */
@TableName("`achievement_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class AchievementInformation implements Serializable {

    // AchievementInformation编号
    @TableId(value = "achievement_information_id", type = IdType.AUTO)
    private Integer achievement_information_id;

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
    // 期末成绩
    @TableField(value = "`final_exam`")
    private String final_exam;
    // 平时成绩
    @TableField(value = "`peacetime_performance`")
    private String peacetime_performance;
    // 总成绩
    @TableField(value = "`total_score`")
    private String total_score;









    // 更新时间
    @TableField(value = "update_time")
    private Timestamp update_time;

    // 创建时间
    @TableField(value = "create_time")
    private Timestamp create_time;







}
