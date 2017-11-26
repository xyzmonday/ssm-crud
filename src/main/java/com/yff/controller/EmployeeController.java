package com.yff.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yff.dao.EmployeeMapper;
import com.yff.entity.Employee;
import com.yff.entity.EmployeeCustom;
import com.yff.entity.Msg;
import com.yff.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * /emp/{id} get 查询
 * /emp post 保存
 * /emp/{id} put 修改
 * /emp/{id} delete 删除
 */
@Controller
@RequestMapping("/emp")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @GetMapping("/list")
    @ResponseBody
    public Msg getAllEmployees(@RequestParam(value = "pageNum", required = false,
            defaultValue = "1") Integer pageNum) {
        PageHelper.startPage(pageNum, 5);
        List<EmployeeCustom> employeeList = employeeService.getEmployeeList();
        PageInfo<EmployeeCustom> pageInfo = new PageInfo<>(employeeList, 5);
        return Msg.success().put("pageInfo", pageInfo);
    }

    @PostMapping("/save")
    @ResponseBody
    public Msg saveEmployee(Employee employee) {
        employeeService.saveEmployee(employee);
        return Msg.success();
    }
}
