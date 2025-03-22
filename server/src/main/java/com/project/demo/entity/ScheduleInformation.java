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
 * 课表信息：(ScheduleInformation)表实体类
 *
 */
@TableName("`schedule_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class ScheduleInformation implements Serializable {

    // ScheduleInformation编号
    @TableId(value = "schedule_information_id", type = IdType.AUTO)
    private Integer schedule_information_id;

    // 学生用户
    @TableField(value = "`student_users`")
    private Integer student_users;
    // 学生姓名
    @TableField(value = "`student_name`")
    private String student_name;
    // 课表名称
    @TableField(value = "`schedule_name`")
    private String schedule_name;
    // 课表图片
    @TableField(value = "`timetable_picture`")
    private String timetable_picture;
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
