package com.project.demo.controller;

import com.project.demo.entity.WithdrawalInformation;
import com.project.demo.service.WithdrawalInformationService;
import com.project.demo.controller.base.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 退课信息：(WithdrawalInformation)表控制层
 *
 */
@RestController
@RequestMapping("/withdrawal_information")
public class WithdrawalInformationController extends BaseController<WithdrawalInformation, WithdrawalInformationService> {

    /**
     * 退课信息对象
     */
    @Autowired
    public WithdrawalInformationController(WithdrawalInformationService service) {
        setService(service);
    }

    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String,Object> paramMap = service.readBody(request.getReader());
        Map<String, String> mapcourse_no = new HashMap<>();
        mapcourse_no.put("course_no",String.valueOf(paramMap.get("course_no")));
        List listcourse_no = service.selectBaseList(service.select(mapcourse_no, new HashMap<>()));
        if (listcourse_no.size()>0){
            return error(30000, "字段选课编号内容不能重复");
        }
        this.addMap(paramMap);
        String sql = "SELECT MAX(withdrawal_information_id) AS max FROM "+"withdrawal_information";
        Integer max = service.selectBaseCount(sql);
        sql = "UPDATE `course_information` INNER JOIN `withdrawal_information` ON course_information.course_name=withdrawal_information.course_name SET course_information.number_of_people_available= course_information.number_of_people_available + withdrawal_information.number_of_participants WHERE withdrawal_information.withdrawal_information_id="+max;
        service.updateBaseSql(sql);
        return success(1);
    }

}
