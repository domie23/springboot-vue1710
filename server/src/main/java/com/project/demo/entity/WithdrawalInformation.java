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
 * 退课信息：(WithdrawalInformation)表实体类
 *
 */
@TableName("`withdrawal_information`")
@Data
@EqualsAndHashCode(callSuper = false)
public class WithdrawalInformation implements Serializable {

    // WithdrawalInformation编号
    @TableId(value = "withdrawal_information_id", type = IdType.AUTO)
    private Integer withdrawal_information_id;

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
    // 退课原因
    @TableField(value = "`reason_for_withdrawal`")
    private String reason_for_withdrawal;
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
