package com.project.demo.controller;

import com.project.demo.entity.CourseSelectionInformation;
import com.project.demo.service.CourseSelectionInformationService;
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
 * 选课信息：(CourseSelectionInformation)表控制层
 *
 */
@RestController
@RequestMapping("/course_selection_information")
public class CourseSelectionInformationController extends BaseController<CourseSelectionInformation, CourseSelectionInformationService> {

    /**
     * 选课信息对象
     */
    @Autowired
    public CourseSelectionInformationController(CourseSelectionInformationService service) {
        setService(service);
    }

    @PostMapping("/add")
    @Transactional
    public Map<String, Object> add(HttpServletRequest request) throws IOException {
        Map<String,Object> paramMap = service.readBody(request.getReader());
        this.addMap(paramMap);
        String sql = "SELECT MAX(course_selection_information_id) AS max FROM "+"course_selection_information";
        Integer max = service.selectBaseCount(sql);
        sql = ("SELECT count(*) count FROM `course_information` INNER JOIN `course_selection_information` ON course_information.course_name=course_selection_information.course_name WHERE course_information.number_of_people_available < course_selection_information.number_of_participants AND course_selection_information.course_selection_information_id="+max).replaceAll("&#60;","<");
        Integer count = service.selectBaseCount(sql);
        if(count>0){
            sql = "delete from "+"course_selection_information"+" WHERE "+"course_selection_information_id"+" ="+max;
            service.deleteBaseSql(sql);
            return error(30000,"选课人数已满!");
        }
        sql = "UPDATE `course_information` INNER JOIN `course_selection_information` ON course_information.course_name=course_selection_information.course_name SET course_information.number_of_people_available= course_information.number_of_people_available - course_selection_information.number_of_participants WHERE course_selection_information.course_selection_information_id="+max;
        service.updateBaseSql(sql);
        return success(1);
    }

}
