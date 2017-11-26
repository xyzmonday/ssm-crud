package com.yff.test;

import com.github.pagehelper.PageInfo;
import com.yff.entity.EmployeeCustom;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(value = {"classpath:spring/applicationContext-*.xml","classpath:spring/spring-mvc.xml"})
public class EmployeeControllerTest {

    @Autowired
    private WebApplicationContext applicationContext;

    private MockMvc mockMvc;

    @Before
    public void init() {
        mockMvc = MockMvcBuilders.webAppContextSetup(applicationContext).build();
    }

    //测试分页
    @Test
    public void testPage() {
        try {
            MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emp/list").param("pageNum", "1"))
                    .andReturn();
            MockHttpServletRequest request = mvcResult.getRequest();
            PageInfo<EmployeeCustom> pageInfo = (PageInfo) request.getAttribute("pageInfo");
            System.out.println(pageInfo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
