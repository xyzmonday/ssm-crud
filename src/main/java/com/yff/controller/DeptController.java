package com.yff.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yff.entity.Department;
import com.yff.entity.EmployeeCustom;
import com.yff.entity.Msg;
import com.yff.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/dept")
public class DeptController {

    @Autowired
    private DeptService deptService;


    @GetMapping("/list")
    @ResponseBody
    public Msg  getAllDepartment() {
        List<Department> departments = deptService.getDepartmentList();
        return Msg.success().put("departments", departments);
    }
}
