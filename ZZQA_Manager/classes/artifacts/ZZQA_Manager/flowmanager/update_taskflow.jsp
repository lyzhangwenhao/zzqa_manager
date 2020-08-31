<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@page
        import="org.springframework.web.context.support.WebApplicationContextUtils" %>
<%@page import="com.zzqa.service.interfaces.user.UserManager" %>
<%@page import="com.zzqa.pojo.user.User" %>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager" %>
<%@page import="com.zzqa.pojo.flow.Flow" %>
<%@page import="com.zzqa.service.interfaces.task.TaskManager" %>
<%@page import="com.zzqa.pojo.task.Task" %>
<%@page import="com.zzqa.service.interfaces.linkman.LinkmanManager" %>
<%@page import="com.zzqa.pojo.linkman.Linkman" %>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager" %>
<%@page import="com.zzqa.pojo.file_path.File_path" %>
<%@page
        import="com.zzqa.service.interfaces.position_user.Position_userManager" %>
<%@page import="com.zzqa.pojo.position_user.Position_user" %>
<%@page import="com.zzqa.util.DataUtil" %>
<%@page import="com.zzqa.util.FormTransform" %>
<%@ page import="com.zzqa.util.DateTrans" %>
<%
    request.setCharacterEncoding("UTF-8");
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    UserManager userManager = (UserManager) WebApplicationContextUtils
            .getRequiredWebApplicationContext(getServletContext())
            .getBean("userManager");
    FlowManager flowManager = (FlowManager) WebApplicationContextUtils
            .getRequiredWebApplicationContext(getServletContext())
            .getBean("flowManager");
    TaskManager taskManager = (TaskManager) WebApplicationContextUtils
            .getRequiredWebApplicationContext(getServletContext())
            .getBean("taskManager");
    LinkmanManager linkmanManager = (LinkmanManager) WebApplicationContextUtils
            .getRequiredWebApplicationContext(getServletContext())
            .getBean("linkmanManager");
    File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
            .getRequiredWebApplicationContext(getServletContext())
            .getBean("file_pathManager");
    Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
            .getRequiredWebApplicationContext(getServletContext())
            .getBean("position_userManager");

    if (session.getAttribute("uid") == null) {
        request.getRequestDispatcher("/login.jsp").forward(request,
                response);
        return;
    }
    int uid = (Integer) session.getAttribute("uid");
    User mUser = userManager.getUserByID(uid);
    if (mUser == null) {
        request.getRequestDispatcher("/login.jsp").forward(request,
                response);
        return;
    }
    if (session.getAttribute("task_id") == null) {
        request.getRequestDispatcher("/login.jsp").forward(request,
                response);
        return;
    }
    int tid = (Integer) session.getAttribute("task_id");
    String[] flowTypeArray = DataUtil.getFlowTypeArray();
    Task task = taskManager.getTaskByID(tid);
    Flow flow = flowManager.getNewFlowByFID(1, tid);
    if (flow == null || task == null) {
        request.getRequestDispatcher("/login.jsp").forward(request,
                response);
        return;
    }
    int operation = flow.getOperation();
    String[] pCaseArray = DataUtil.getPCaseArray();
    String[] stageArray = DataUtil.getStageArray();
    String[] pTypeArray = DataUtil.getPTypeArray();
    List<Linkman> linkmanList1 = linkmanManager.getLinkmanListLimit(1, tid, 1, 0);
    List<Linkman> linkmanList2 = linkmanManager.getLinkmanListLimit(1, tid, 2, 0);
    List<Linkman> linkmanList3 = linkmanManager.getLinkmanListLimit(1, tid, 3, 0);
    List<File_path> fpathList1 = file_pathManager
            .getAllFileByCondition(1, tid, 1, 0);
    List<File_path> fpathList2 = file_pathManager
            .getAllFileByCondition(1, tid, 2, 0);
    List<File_path> fpathList6 = file_pathManager
            .getAllFileByCondition(1, tid, 6, 0);
    List<Flow> reasonList = flowManager.getReasonList(1, tid);
    String[] pCategoryArray = DataUtil.getPCategoryArray();
    String[] productTypeArray = DataUtil.getProductTypeArray();
    String[] productTypeArrayTrue = DataUtil.getProductTypeArrayTrue();
%>

<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">

    <title>修改任务单流程</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <link rel="stylesheet" type="text/css" href="css/top.css">
    <link rel="stylesheet" type="text/css" href="css/flowmanager.css">
    <link rel="stylesheet" type="text/css" href="css/update_taskflow.css">
    <link rel="stylesheet" type="text/css" href="css/custom.css">
    <link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
    <link rel="stylesheet" type="text/css" href="css/default.css">
    <link rel="stylesheet" type="text/css"
          href="css/jquery.filer-dragdropbox-theme.css">
    <script src="js/showdate1.js" type="text/javascript"></script>
    <script src="js/prettify.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script src="js/jquery.filer.min.js" type="text/javascript"></script>
    <script src="js/custom.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
    <script type="text/javascript" src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="js/dialog.js"></script>
    <script type="text/javascript" src="js/public.js"></script>

    <!--[if IE]>
    <script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
    <![endif]-->
    <!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
    <script type="text/javascript">
        var file_num =<%=fpathList1.size()%>;
        var linkman_user_num =<%=linkmanList1.size()%>;
        var linkman_bill_num =<%=linkmanList2.size()%>;
        var linkman_device_num =<%=linkmanList3.size()%>;

        //删除图片
        function delFile(id, name, type) {
            initdiglogtwo2("提示信息", "你确定要删除文件<br/>【" + name + "】吗？");
            $("#confirm2").click(function () {
                $("#twobtndialog").dialog("close");
                $.ajax({
                    type: "post",//post方法
                    url: "DeleteFileServlet",
                    data: {"id": id, "type": "delTaskFile"},
                    timeout: 10000, //超时时间设置，单位毫秒
                    complete: function (XMLHttpRequest, status) { //请求完成后最终执行参数
                        if (status == 'timeout') {//超时,status还有success,error等值的情况
                            initdiglog2("提示信息", "请求超时，请重试!");
                        }
                    },
                    //ajax成功的回调函数
                    success: function (returnData) {
                        if (returnData == 1) {
                            var na = "#file_div" + id;
                            $(na).remove();
                            if (type == 1) {
                                file_num--;
                                if (successUploadFileNum1 == 0 && file_num == 0) {
                                    initdiglog2("提示信息", "删除成功，请上传供货清单，切勿中途退出！");
                                } else {
                                    initdiglog2("提示信息", "删除成功！");
                                }
                            } else {
                                initdiglog2("提示信息", "删除成功！");
                            }
                        }
                    }
                });
            });
        }

        function testPhoneNumber(phone) {
            if (phone.length > 0) {
                var reg_phone = /^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
                var reg_mobile = /^1\d{10}$/;
                if (reg_phone.test(phone) || reg_mobile.test(phone)) {
                    return true;
                }
                return false;
            } else {
                return false;
            }
        }

        function alertFlow() {
            var k = 0;

            var selectValue = $("#pCategory option:selected").val();
            // var categorySelect = document.getElementsByName("pCategory")[0];	//获取项目类型下拉列表框
            // var index = categorySelect.selectedIndex;							//获取选中的元素索引
            // var selectValue = categorySelect.options[index].value;				//获取选中索引的值
            var productTypeValue = "";
            if (selectValue == 0) {
                var strs = document.getElementsByName("fanProductType");
                for (i in strs) {
                    if (strs[i].checked) {
                        // alert(strs[i].value);
                        productTypeValue += strs[i].value + ",";
                    }
                }

                document.flowform.productTypeValue.value = productTypeValue;
                if (document.flowform.productTypeValue.value.length < 1) {
                    k++;
                    document.getElementById("productType_error").innerText = "请选择产品类型"
                } else {
                    document.getElementById("productType_error").innerText = "";
                }
            }

            if (document.flowform.project_name.value.length < 1) {
                k++;
                document.getElementById("pname_error").innerText = "请正确输入项目名称(只能为纯数字)";
            } else {
                document.getElementById("pname_error").innerText = "";
            }

            if (document.flowform.project_id.value.length < 1) {
                k++;
                document.getElementById("pid_error").innerText = "请输入项目编号";
            } else {
                document.getElementById("pid_error").innerText = "";
            }

            <%if ("1".equals(task.getIs_new_data())) {%>
            if (document.flowform.fan_num.value.length < 1) {
                k++;
                document.getElementById("pnum_error").innerText = "请正确输入风机数量(只能为纯数字)"
            } else {
                document.getElementById("pnum_error").innerText = "";
            }

            if (document.flowform.factory.value.length < 1) {
                k++;
                document.getElementById("pfactory_error").innerText = "请正确输入项目名称及主机厂家"
            } else {
                document.getElementById("pfactory_error").innerText = "";
            }

            if (document.flowform.submit_date.value.length < 1) {
                k++;
                document.getElementById("psubmit_date_error").innerText = "请正确输入项目交期(只能为纯数字)"
            } else {
                document.getElementById("psubmit_date_error").innerText = "";
            }

            if (document.flowform.equipment_type.value.length < 1) {
                k++;
                document.getElementById("pequipment_type_error").innerText = "请输入设备类型";
            } else {
                document.getElementById("pequipment_type_error").innerText = "";
            }
            <% } %>


            if (document.flowform.customer.value.length < 1) {
                k++;
                document.getElementById("customer_error").innerText = "请输入用户名称";
            } else {
                document.getElementById("customer_error").innerText = "";
            }
            if (strToDate(document.flowform.delivery_time.value)) {
                k++;
                document.getElementById("time_error").innerText = "请检查时间格式";
            } else {
                document.getElementById("time_error").innerText = "";
            }
            var linkman_user = "";
            var linkman = document.getElementById("linkman_user0").value;
            var phone = document.getElementById("phone_user0").value;
            if (linkman != null && linkman.length > 0 && testPhoneNumber(phone)) {
                document.getElementById("linkman_user0").value = linkman;
                document.getElementById("phone_user0").value = phone;
                document.getElementById("linkman_user_span0").innerText = "";
                if (linkman_user.length == 0) {
                    linkman_user = linkman + "の" + phone;
                } else {
                    linkman_user += "い" + linkman + "の" + phone;
                }
            } else {
                k++;
                if (linkman.length < 1 && phone.length < 1) {
                    document.getElementById("linkman_user_span0").innerText = "请输入姓名和电话";
                } else if (linkman.length < 1) {
                    document.getElementById("linkman_user_span0").innerText = "请输入姓名";
                } else if (phone.length < 1) {
                    document.getElementById("linkman_user_span0").innerText = "请输入电话";
                } else if (!testPhoneNumber(phone)) {
                    document.getElementById("linkman_user_span0").innerText = "电话格式不正确";
                } else {
                    document.getElementById("linkman_user_span0").innerText = "信息输入有误";
                }
            }
            for (var i = 1; i < linkman_user_num + 1; i++) {
                if (document.getElementById("linkman_user_div" + i)) {
                    var linkman = document.getElementById("linkman_user" + i).value;
                    var phone = document.getElementById("phone_user" + i).value;
                    if (linkman != null && linkman.length > 0 && testPhoneNumber(phone)) {
                        document.getElementById("linkman_user" + i).value = linkman;
                        document.getElementById("phone_user" + i).value = phone;
                        document.getElementById("linkman_user_span" + i).innerText = "";
                        if (linkman_user.length == 0) {
                            linkman_user = linkman + "の" + phone;
                        } else {
                            linkman_user += "い" + linkman + "の" + phone;
                        }
                    } else {
                        k++;
                        if (linkman.length < 1 && phone.length < 1) {
                            document.getElementById("linkman_user_span" + i).innerText = "请输入姓名和电话";
                        } else if (linkman.length < 1) {
                            document.getElementById("linkman_user_span" + i).innerText = "请输入姓名";
                        } else if (phone.length < 1) {
                            document.getElementById("linkman_user_span" + i).innerText = "请输入电话";
                        } else if (!testPhoneNumber(phone)) {
                            document.getElementById("linkman_user_span" + i).innerText = "电话格式不正确";
                        } else {
                            document.getElementById("linkman_user_span" + i).innerText = "信息输入有误";
                        }
                    }
                }
            }
            document.flowform.linkman_user.value = linkman_user;
            <%if (!"1".equals(task.getIs_new_data())) { %>
            var linkman_bill = "";
            var linkman = document.getElementById("linkman_bill0").value;
            var phone = document.getElementById("phone_bill0").value;
            if (linkman != null && linkman.length > 0 && testPhoneNumber(phone)) {
                document.getElementById("linkman_bill0").value = linkman;
                document.getElementById("phone_bill0").value = phone;
                document.getElementById("linkman_bill_span0").innerText = "";
                if (linkman_bill.length == 0) {
                    linkman_bill = linkman + "の" + phone;
                } else {
                    linkman_bill += "い" + linkman + "の" + phone;
                }
            } else {
                k++;
                if (linkman.length < 1 && phone.length < 1) {
                    document.getElementById("linkman_bill_span0").innerText = "请输入姓名和电话";
                } else if (linkman.length < 1) {
                    document.getElementById("linkman_bill_span0").innerText = "请输入姓名";
                } else if (phone.length < 1) {
                    document.getElementById("linkman_bill_span0").innerText = "请输入电话";
                } else if (!testPhoneNumber(phone)) {
                    document.getElementById("linkman_bill_span0").innerText = "电话格式不正确";
                } else {
                    document.getElementById("linkman_bill_span0").innerText = "信息输入有误";
                }
            }
            for (var i = 1; i < linkman_bill_num + 1; i++) {
                if (document.getElementById("linkman_bill_div" + i)) {
                    var linkman = document.getElementById("linkman_bill" + i).value;
                    var phone = document.getElementById("phone_bill" + i).value;
                    if (linkman != null && linkman.length > 0 && testPhoneNumber(phone)) {
                        document.getElementById("linkman_bill" + i).value = linkman;
                        document.getElementById("phone_bill" + i).value = phone;
                        document.getElementById("linkman_bill_span" + i).innerText = "";
                        if (linkman_bill.length == 0) {
                            linkman_bill = linkman + "の" + phone;
                        } else {
                            linkman_bill += "い" + linkman + "の" + phone;
                        }
                    } else {
                        k++;
                        if (linkman.length < 1 && phone.length < 1) {
                            document.getElementById("linkman_bill_span" + i).innerText = "请输入姓名和电话";
                        } else if (linkman.length < 1) {
                            document.getElementById("linkman_bill_span" + i).innerText = "请输入姓名";
                        } else if (phone.length < 1) {
                            document.getElementById("linkman_bill_span" + i).innerText = "请输入电话";
                        } else if (!testPhoneNumber(phone)) {
                            document.getElementById("linkman_bill_span" + i).innerText = "电话格式不正确";
                        } else {
                            document.getElementById("linkman_bill_span" + i).innerText = "信息输入有误";
                        }
                    }
                }
            }
            document.flowform.linkman_bill.value = linkman_bill;
            <% } %>
            var linkman_device = "";
            var linkman = document.getElementById("linkman_device0").value;
            var phone = document.getElementById("phone_device0").value;
            if (linkman != null && linkman.length > 0 && testPhoneNumber(phone)) {
                document.getElementById("linkman_device0").value = linkman;
                document.getElementById("phone_device0").value = phone;
                document.getElementById("linkman_device_span0").innerText = "";
                if (linkman_device.length == 0) {
                    linkman_device = linkman + "の" + phone;
                } else {
                    linkman_device += "い" + linkman + "の" + phone;
                }
            } else {
                k++;
                if (linkman.length < 1 && phone.length < 1) {
                    document.getElementById("linkman_device_span0").innerText = "请输入姓名和电话";
                } else if (linkman.length < 1) {
                    document.getElementById("linkman_device_span0").innerText = "请输入姓名";
                } else if (phone.length < 1) {
                    document.getElementById("linkman_device_span0").innerText = "请输入电话";
                } else if (!testPhoneNumber(phone)) {
                    document.getElementById("linkman_device_span0").innerText = "电话格式不正确";
                } else {
                    document.getElementById("linkman_device_span0").innerText = "信息输入有误";
                }
            }
            for (var i = 1; i < linkman_device_num + 1; i++) {
                if (document.getElementById("linkman_device_div" + i)) {
                    var linkman = document.getElementById("linkman_device" + i).value;
                    var phone = document.getElementById("phone_device" + i).value;
                    if (linkman != null && linkman.length > 0 && testPhoneNumber(phone)) {
                        document.getElementById("linkman_device" + i).value = linkman;
                        document.getElementById("phone_device" + i).value = phone;
                        document.getElementById("linkman_device_span" + i).innerText = "";
                        if (linkman_device.length == 0) {
                            linkman_device = linkman + "の" + phone;
                        } else {
                            linkman_device += "い" + linkman + "の" + phone;
                        }
                    } else {
                        k++;
                        if (linkman.length < 1 && phone.length < 1) {
                            document.getElementById("linkman_device_span" + i).innerText = "请输入姓名和电话";
                        } else if (linkman.length < 1) {
                            document.getElementById("linkman_device_span" + i).innerText = "请输入姓名";
                        } else if (phone.length < 1) {
                            document.getElementById("linkman_device_span" + i).innerText = "请输入电话";
                        } else if (!testPhoneNumber(phone)) {
                            document.getElementById("linkman_device_span" + i).innerText = "电话格式不正确";
                        } else {
                            document.getElementById("linkman_device_span" + i).innerText = "信息输入有误";
                        }
                    }
                }
            }
            document.flowform.linkman_device.value = linkman_device;
            if (successUploadFileNum1 == 0 && file_num == 0) {
                k++;
                document.getElementById("file_input1_error").innerText = "请选择文件";
            } else {
                document.getElementById("file_input1_error").innerText = "";
            }
            if (document.flowform.other.value.replace(/\s+/g, "").length < 1) {
                initdiglog2("提示信息", "请在移交项目中心一栏填写风机台数!");
                k++;
                return;
            }
            if ($(".div_testarea").length > 0) {
                if ($(".div_testarea").val().replace(/\s/g, "").length < 1) {
                    initdiglog2("提示信息", "请说明本次修改内容!");
                    k++;
                    return;
                }
            }
            if (k == 0) {
                document.flowform.submit();
            }
        }

        function addLinkman(n) {
            if (n == 1) {
                var temp = "";
                linkman_user_num++;
                for (var i = 1; i < linkman_user_num; i++) {
                    if (document.getElementById("linkman_user_div" + i)) {
                        var linkman = document.getElementById("linkman_user" + i).value;
                        var phone = document.getElementById("phone_user" + i).value;
                        temp += '<div class="div_padding" id="linkman_user_div' + i + '">' +
                            '姓名：<input type="text" value="' + linkman + '"id="linkman_user' + i + '" maxlength="10" onkeydown="if(event.keyCode==32) return false">' +
                            ' 电话：<input type="phone" value="' + phone + '"id="phone_user' + i + '"  maxlength="20" onkeydown="if(event.keyCode==32) return false">' +
                            ' <img src="images/delete.png" title="删除" onclick="delLinkman(1,' + i + ');">' +
                            ' <span id="linkman_user_span' + i + '"></span></div>';
                    }
                }
                var linkman = document.flowform.linkman_user0.value;
                var phone = document.flowform.phone_user0.value;
                var linkman_div = document.getElementById("linkman_user_div");
                temp += '<div class="div_padding" id="linkman_user_div' + linkman_user_num + '">' +
                    '姓名：<input type="text" value="' + linkman + '"id="linkman_user' + linkman_user_num + '" maxlength="10" onkeydown="if(event.keyCode==32) return false">' +
                    ' 电话：<input type="phone" value="' + phone + '"id="phone_user' + linkman_user_num + '"  maxlength="20" onkeydown="if(event.keyCode==32) return false">' +
                    ' <img src="images/delete.png" title="删除" onclick="delLinkman(1,' + linkman_user_num + ');">' +
                    ' <span id="linkman_user_span' + linkman_user_num + '"></span></div>';
                linkman_div.innerHTML = temp;
                document.flowform.linkman_user0.value = "";
                document.flowform.phone_user0.value = "";
            } else if (n == 2) {
                linkman_bill_num++;
                var temp = "";
                for (var i = 1; i < linkman_bill_num; i++) {
                    if (document.getElementById("linkman_bill_div" + i)) {
                        var linkman = document.getElementById("linkman_bill" + i).value;
                        var phone = document.getElementById("phone_bill" + i).value;
                        temp += '<div class="div_padding" id="linkman_bill_div' + i + '">' +
                            '姓名：<input type="text" value="' + linkman + '"id="linkman_bill' + i + '" maxlength="10" onkeydown="if(event.keyCode==32) return false">' +
                            ' 电话：<input type="phone" value="' + phone + '"id="phone_bill' + i + '"  maxlength="20" onkeydown="if(event.keyCode==32) return false">' +
                            ' <img src="images/delete.png" title="删除" onclick="delLinkman(1,' + i + ');">' +
                            ' <span id="linkman_bill_span' + i + '"></span></div>';
                    }
                }
                var linkman = document.flowform.linkman_bill0.value;
                var phone = document.flowform.phone_bill0.value;
                var linkman_div = document.getElementById("linkman_bill_div");
                temp += '<div class="div_padding" id="linkman_bill_div' + linkman_bill_num + '">' +
                    '姓名：<input type="text" value="' + linkman + '"id="linkman_bill' + linkman_bill_num + '" maxlength="10" onkeydown="if(event.keyCode==32) return false">' +
                    ' 电话：<input type="phone" value="' + phone + '"id="phone_bill' + linkman_bill_num + '"  maxlength="20" onkeydown="if(event.keyCode==32) return false">' +
                    ' <img src="images/delete.png" title="删除" onclick="delLinkman(2,' + linkman_bill_num + ');">' +
                    ' <span id="linkman_bill_span' + linkman_bill_num + '"></span></div>';
                linkman_div.innerHTML = temp;
                document.flowform.linkman_bill0.value = "";
                document.flowform.phone_bill0.value = "";
            } else if (n == 3) {
                var temp = "";
                linkman_device_num++;
                for (var i = 1; i < linkman_device_num; i++) {
                    if (document.getElementById("linkman_device_div" + i)) {
                        var linkman = document.getElementById("linkman_device" + i).value;
                        var phone = document.getElementById("phone_device" + i).value;
                        temp += '<div class="div_padding" id="linkman_device_div' + i + '">' +
                            '姓名：<input type="text" value="' + linkman + '"id="linkman_device' + i + '" maxlength="10" onkeydown="if(event.keyCode==32) return false">' +
                            ' 电话：<input type="phone" value="' + phone + '"id="phone_device' + i + '"  maxlength="20" onkeydown="if(event.keyCode==32) return false">' +
                            ' <img src="images/delete.png" title="删除" onclick="delLinkman(1,' + i + ');">' +
                            ' <span id="linkman_device_span' + i + '"></span></div>';
                    }
                }
                var linkman = document.flowform.linkman_device0.value;
                var phone = document.flowform.phone_device0.value;
                var linkman_div = document.getElementById("linkman_device_div");
                temp += '<div class="div_padding" id="linkman_device_div' + linkman_device_num + '">' +
                    '姓名：<input type="text" value="' + linkman + '"id="linkman_device' + linkman_device_num + '" maxlength="10" onkeydown="if(event.keyCode==32) return false">' +
                    ' 电话：<input type="phone" value="' + phone + '"id="phone_device' + linkman_device_num + '"  maxlength="20" onkeydown="if(event.keyCode==32) return false">' +
                    ' <img src="images/delete.png" title="删除" onclick="delLinkman(3,' + linkman_device_num + ');">' +
                    ' <span id="linkman_device_span' + linkman_device_num + '"></span></div>';
                linkman_div.innerHTML = temp;
                document.flowform.linkman_device0.value = "";
                document.flowform.phone_device0.value = "";
            }
        }

        function strToDate(str) {
            //判断日期格式符合YYYY-MM-DD标准
            var tempStrs = str.split("-");
            if (tempStrs.length == 3 && validate(tempStrs[0]) && tempStrs[0].length == 4 && validate(tempStrs[1]) && tempStrs[1] < 13 && validate(tempStrs[2]) && tempStrs[2] < 32) {
                return false;
            }
            return true;
        }

        function validate(sDouble) {
            //检验是否为正数
            var re = /^\d+(?=\.{0,1}\d+$|$)/;
            return re.test(sDouble) && sDouble > 0;
        }

        function delLinkman(n, name) {
            var id = "";
            var t_num = 1;
            var t_name = "";
            var t_phone = "";
            var t_div = "";
            if (n == 1) {
                id = "linkman_user_div" + name;
                t_div = "linkman_user_div";
                t_num = linkman_user_num;
                t_name = "linkman_user";
                t_phone = "phone_user";
            } else if (n == 2) {
                id = "linkman_bill_div" + name;
                t_div = "linkman_bill_div";
                t_num = linkman_bill_num;
                t_name = "linkman_bill";
                t_phone = "phone_bill";
            } else if (n == 3) {
                id = "linkman_device_div" + name;
                t_div = "linkman_device_div";
                t_num = linkman_device_num;
                t_name = "linkman_device";
                t_phone = "phone_device";
            }
            var obj = document.getElementById(id);
            if (obj != null) {
                if (name == 0) {
                    for (var i = t_num; i > 0; i--) {
                        if (document.getElementById(t_div + i)) {
                            document.getElementById(t_name + 0).value = document.getElementById(t_name + i).value;
                            document.getElementById(t_phone + 0).value = document.getElementById(t_phone + i).value;
                            var lastId = t_div + i;
                            var lastObj = document.getElementById(lastId);
                            lastObj.parentNode.removeChild(lastObj);
                            break;
                        }
                    }
                    if (i == 0) {
                        initdiglog2("提示信息", "至少保留一行！");
                        return;
                    }
                } else {
                    obj.parentNode.removeChild(obj);
                }
            }
        }

        function setTime(time, obj) {
            var nowdate = "<%=DataUtil.getTadayStr()%>";
            //修改time的时间
            if (compareTime1(nowdate, time)) {
                obj.value = time;
            } else {
                initdiglogtwo2("提示信息", "发货时间早于当前时间，请确认输入无误？");
                $("#confirm2").click(function () {
                    $("#twobtndialog").dialog("close");
                    obj.value = time;
                });
            }
        }

        function isFanProject() {
            // var pCategory = document.getElementsByName("pCategory");
            // if ("风电项目" pCategory)
            var categorySelect = document.getElementsByName("pCategory")[0];	//获取项目类型下拉列表框
            var index = categorySelect.selectedIndex;							//获取选中的元素索引
            var selectValue = categorySelect.options[index].value;				//获取选中索引的值
            // alert(selectValue);
            if (selectValue != 0) {
                //不为风电项目
                // alert(selectValue+"-1");
                document.getElementById("fanProject").innerHTML = "<select name='productType'><%for(int i=0;i<productTypeArray.length;i++){ %> <option value='<%=i%>'><%=productTypeArray[i]%></option><%} %> </select>";
                <%--$("#fanProject").html("<select name='productType'><%for(int i=0;i<productTypeArray.length;i++){ %> <option value='<%=i%>'><%=productTypeArray[i]%></option><%} %> </select>");--%>
            } else {
                //为风电项目
                // alert(selectValue+"-2");
                var strhtml = "<div>\n" +
                    "<%for (int i=0;i<10;i++){ %>\n" +
                    "<label><input style=\"width: 14px;height:14px\" type=\"checkbox\" name=\"fanProductType\" value=\"<%=productTypeArrayTrue[i]%>\"><%=productTypeArrayTrue[i]%></label>\n" +
                    "<%} %>\n" +
                    "</div>\n" +
                    "<div>\n" +
                    "<%for (int i=10;i<productTypeArrayTrue.length;i++){ %>\n" +
                    "<label><input style=\"width: 14px;height:14px\" type=\"checkbox\" name=\"fanProductType\" value=\"<%=productTypeArrayTrue[i]%>\"><%=productTypeArrayTrue[i]%></label>\n" +
                    "<%} %>\n" + "<span id='productType_error'></span>" +
                    "</div>";
                document.getElementById("fanProject").innerHTML = strhtml;
                // $("#fanProject").html(strhtml);
            }

        }

        function saveTaskFile6() {
            if (successUploadFileNum6 > 0) {
                initdiglogtwo2("提示信息", "请确认文件上传无误并及时告知相关人员！");
                $("#confirm2").click(function () {
                    $("#twobtndialog").dialog("close");
                    $.ajax({
                        type: "post",//post方法
                        url: "FlowManagerServlet",
                        data: {"type": "alertTaskProjectFile6"},
                        error: function (XMLHttpRequest, status) { //请求完成后最终执行参数
                            initdiglog2("提示信息", "请求错误，请刷新重试!");
                        },
                        //ajax成功的回调函数
                        success: function (returnData) {
                            location.reload();
                        }
                    });
                });
            } else {
                initdiglog2("提示信息", "请备注文件！");
                return;
            }
        }
    </script>
</head>

<body>
<jsp:include page="/top.jsp">
    <jsp:param name="name" value="<%=mUser.getName() %>"/>
    <jsp:param name="level" value="<%=mUser.getLevel() %>"/>
    <jsp:param name="index" value="1"/>
</jsp:include>
<div class="div_center">
    <table class="table_center">
        <tr>
            <jsp:include page="/flowmanager/flowTab.jsp">
                <jsp:param name="index" value="0"/>
            </jsp:include>
            <td class="table_center_td2">
                <form action="FlowManagerServlet?type=alerttaskflow&task_id=<%=task.getId()%>&uid=<%=mUser.getId() %>&file_time=<%=System.currentTimeMillis()%>"
                      method="post"
                      name="flowform" enctype="multipart/form-data">
                    <div class="td2_div">
                        <div class="td2_div1">
                            项目任务单
                        </div>
                        <table class="td2_table1">
                            <tr class="table1_tr1">
                                <td class="table1_tr1_td1">
                                    <span class="star">*</span>项目类型
                                </td>
                                <td class="table1_tr1_td2">
                                    <%--<select name="pCategory">
                                        <%for(int i=0;i<pCategoryArray.length;i++){ %>
                                            <option value="<%=i%>"  <%=i==task.getProject_category()?"selected":"" %>><%=pCategoryArray[i]%></option>
                                        <%} %>
                                    </select>--%>
                                    <select id="pCategory" onchange="isFanProject()" name="pCategory">
                                        <%for (int i = 0; i < pCategoryArray.length; i++) { %>
                                        <option value="<%=i%>" <%=i == task.getProject_category() ? "selected" : "" %>><%=pCategoryArray[i]%>
                                        </option>
                                        <%} %>
                                    </select>
                                </td>
                            </tr>
                            <%--<tr class="table1_tr1">
                                <td class="table1_tr1_td1">
                                    <span class="star">*</span>产品类型
                                </td>
                                <td class="table1_tr1_td2">
                                    <select name="productType">
                                        <%for(int i=1;i<productTypeArray.length;i++){ %>
                                            <option value="<%=i%>" <%=i==task.getProduct_type()?"selected":"" %>><%=productTypeArray[i]%></option>
                                        <%} %>
                                    </select>
                                </td>
                            </tr>--%>
                            <tr class="table1_tr1">
                                <td class="table1_tr1_td1">
                                    <span class="star">*</span>产品类型
                                </td>
                                <td class="table1_tr1_td2">
                                    <input type="hidden" name="productTypeValue">
                                    <div id="fanProject">

                                        <%if (task.getProject_category() == 0 && "1".equals(task.getIs_new_data())) { %>
                                        <div>
                                            <%for (int i = 0; i < 9; i++) { %>
                                            <label><input style="width: 14px;height:14px" type="checkbox"
                                                          name="fanProductType" value="<%=productTypeArrayTrue[i]%>"
                                                <%=task.getFan_product_type()!=null && task.getFan_product_type().indexOf(productTypeArrayTrue[i])!=-1 ? "checked":"" %> ><%=productTypeArrayTrue[i]%>
                                            </label>
                                            <%} %>
                                        </div>
                                        <div>
                                            <%for (int i = 9; i < productTypeArrayTrue.length; i++) { %>
                                            <label><input style="width: 14px;height:14px" type="checkbox"
                                                          name="fanProductType" value="<%=productTypeArrayTrue[i]%>"
                                                <%=task.getFan_product_type()!=null && task.getFan_product_type().indexOf(productTypeArrayTrue[i])!=-1 ? "checked":"" %> ><%=productTypeArrayTrue[i]%>
                                            </label>
                                            <%} %>
                                            <span id="productType_error"></span>
                                        </div>
                                        <%} else { %>
                                        <select name="productType">
                                            <%for (int i = 1; i < productTypeArray.length; i++) { %>
                                            <option value="<%=i%>" <%=i == task.getProduct_type() ? "selected" : "" %>><%=productTypeArray[i]%>
                                            </option>
                                            <%} %>
                                        </select>
                                        <%} %>

                                    </div>
                                </td>
                            </tr>
                            <tr class="table1_tr1">
                                <td class="table1_tr1_td1">
                                    <span class='star'>*</span>项目序号
                                </td>
                                <td class="table1_tr1_td2">
                                    <input type="number" name="project_name" maxlength="50" required="required"
                                           value="<%=task.getProject_name() %>">
                                    <span id="pname_error"></span>
                                </td>
                            </tr>
                            <tr class="table1_tr2">
                                <td class="table1_tr2_td1">
                                    <span class='star'>*</span>项目编号
                                </td>
                                <td class="table1_tr2_td2">
                                    <input type="text" name="project_id" maxlength="100"
                                           value="<%=task.getProject_id() %>"
                                           onkeyup="value=value.replace(/[^\d]/g,'')">
                                    <span id="pid_error"></span>
                                </td>
                            </tr>
                            <%if (!"1".equals(task.getIs_new_data())) { %>
                            <tr class="table1_tr2">
                                <td class="table1_tr2_td1">
                                    项目质保期：
                                </td>
                                <td class="table1_tr2_td2">
                                    <input type="text" name="project_life" maxlength="50"
                                           value="<%=task.getProject_life() == null?"/" : task.getProject_life()%>">
                                </td>
                            </tr>
                            <tr class="table1_tr2">
                                <td class="table1_tr2_td1">
                                    项目诊断      </br>
                                    报告周期：
                                </td>
                                <td class="table1_tr2_td2">
                                    <input type="text" name="project_report_peried" maxlength="50"
                                           value="<%=task.getProject_report_peried() == null?"/" : task.getProject_report_peried()%>">
                                </td>
                            </tr>
                            <tr class="table1_tr3">
                                <td class="table1_tr3_td1">
                                    <span class='star'>*</span>项目情况
                                </td>
                                <td class="table1_tr3_td2">
                                    <%for (int i = 0; i < pCaseArray.length; i++) { %>
                                    <label><input name="project_case" type="radio"
                                                  value="<%=i %>" <%=task.getProject_case() == i ? "checked" : "" %>/><%=pCaseArray[i] %>
                                    </label>
                                    <%} %>
                                </td>
                            </tr>
                            <tr class="table1_tr4">
                                <td class="table1_tr4_td1">
                                    <span class='star'>*</span>销售阶段
                                </td>
                                <td class="table1_tr4_td2">
                                    <%for (int i = 1; i < stageArray.length; i++) { %>
                                    <label><input name="stage" type="radio"
                                                  value="<%=i %>" <%=task.getStage() == i ? "checked" : "" %>/><%=stageArray[i] %>
                                    </label>
                                    <%} %>
                                </td>
                            </tr>
                            <tr class="table1_tr5">
                                <td class="table1_tr5_td1">
                                    <span class='star'>*</span>工程类型
                                </td>
                                <td class="table1_tr5_td2">
                                    <%for (int i = 0; i < pTypeArray.length; i++) { %>
                                    <label><input name="project_type" type="radio"
                                                  value="<%=i %>" <%=task.getProject_type() == i ? "checked" : "" %>/><%=pTypeArray[i]%>
                                    </label>
                                    <%} %>
                                </td>
                            </tr>
                            <% } else { %>
                            <tr class="table1_tr1">
                                <td class="table1_tr1_td1">
                                    <span class="star">*</span>风机数量
                                </td>
                                <td class="table1_tr1_td2">
                                    <input type="number" name="fan_num" maxlength="50"
                                           value="<%=task.getFan_num() == null?"/" : task.getFan_num()%>"
                                           required="required">
                                    <span id="pnum_error"></span>
                                </td>
                            </tr>

                            <tr class="table1_tr2">
                                <td class="table1_tr2_td1">
                                    <span class="star">*</span>项目名称及主机厂家
                                </td>
                                <td class="table1_tr2_td2">
                                    <input type="text" name="factory" maxlength="100"
                                           value="<%=task.getFactory() == null?"/" : task.getFactory()%>"
                                           required="required">
                                    <span id="pfactory_error"></span>
                                </td>
                            </tr>
                            <tr class="table1_tr1">
                                <td class="table1_tr1_td1">
                                    <span class="star">*</span>交期(周)
                                </td>
                                <td class="table1_tr1_td2">
                                    <input type="number" name="submit_date" maxlength="50"
                                           value="<%=task.getSubmit_date() == null?"/" : task.getSubmit_date()%>"
                                           required="required">
                                    <span id="psubmit_date_error"></span>
                                </td>
                            </tr>
                            <tr class="table1_tr4">
                                <td class="table1_tr4_td1">
                                    <span class="star">*</span>合同类型
                                </td>
                                <td class="table1_tr4_td2">
                                    <label><input name="contract_type" type="radio"
                                                  value="试用" <%="试用".equals(task.getContract_type()) ? "checked" : ""%> />试用</label>
                                    <label><input name="contract_type" type="radio"
                                                  value="签订技术协议" <%="签订技术协议".equals(task.getContract_type())?"checked":""%>>签订技术协议</label>
                                    <label><input name="contract_type" type="radio"
                                                  value="签订合同及协议" <%="签订合同及协议".equals(task.getContract_type())?"checked":""%>>签订合同及协议</label>
                                    <label><input name="contract_type" type="radio"
                                                  value="其他" <%="其他".equals(task.getContract_type())?"checked":""%>>其他</label>
                                </td>
                            </tr>
                            <tr class="table1_tr2">
                                <td class="table1_tr2_td1">
                                    <span class="star">*</span>设备类型
                                </td>
                                <td class="table1_tr2_td2">
                                    <input type="text" name="equipment_type" maxlength="100"
                                           value=<%=task.getEquipment_type()%> required="required">
                                    <span id="pequipment_type_error"></span>
                                </td>
                            </tr>
                            <% } %>

                        </table>
                        <table class="td2_table2">
                            <tr class="table2_tr1">
                                <td class="table2_tr1_td1">
                                    用户名称
                                </td>
                                <td class="table2_tr1_td2">
                                    <input type="text" name="customer" maxlength="100" value="<%=task.getCustomer() %>">
                                    <span id="customer_error"></span>
                                </td>
                            </tr>
                            <tr class="table2_tr2">
                                <td class="table2_tr2_td1">
                                    <span class='star'>*</span>用户联系人
                                </td>
                                <input type="hidden" name="linkman_user">
                                <td class="table2_tr2_td2">
                                    <div id="linkman_user_div">
                                        <%
                                            int len1 = linkmanList1.size();
                                            for (int i = 1; i < len1; i++) {
                                        %>
                                        <div class="div_padding" id="linkman_user_div<%=i%>">
                                            姓名：<input type="text" value="<%=linkmanList1.get(i).getLinkman() %>"
                                                      id="linkman_user<%=i %>" maxlength="10"
                                                      onkeydown="if(event.keyCode==32) return false">
                                            电话：<input type="phone" value="<%=linkmanList1.get(i).getPhone() %>"
                                                      id="phone_user<%=i %>" maxlength="20"
                                                      onkeydown="if(event.keyCode==32) return false">
                                            <img src="images/delete.png" title="删除" onclick="delLinkman(1,<%=i %>);">
                                            <span id="linkman_user_span<%=i %>"></span>
                                        </div>
                                        <%} %>
                                    </div>
                                    <div id="linkman_user_div0" class="div_padding">
                                        姓名：<input type="text" id="linkman_user0" maxlength="10"
                                                  value="<%=linkmanList1.size()>0?linkmanList1.get(0).getLinkman():""%>"
                                                  onkeydown="if(event.keyCode==32) return false">
                                        电话：<input type="phone" id="phone_user0" maxlength="20"
                                                  value="<%=linkmanList1.size()>0?linkmanList1.get(0).getPhone():""%>"
                                                  onkeydown="if(event.keyCode==32) return false">
                                        <img src="images/delete.png" title="删除" onclick="delLinkman(1,0);">
                                        <img src="images/add_linkman.png" style="margin-left: 10px" title="添加"
                                             onclick="addLinkman(1);">
                                        <span id="linkman_user_span0" style="margin-left: 10px"></span>
                                    </div>
                                </td>
                            </tr>
                            <%if (!"1".equals(task.getIs_new_data())) { %>
                            <tr class="table2_tr3">
                                <td class="table2_tr3_td1">
                                    <span class='star'>*</span>发票接收人
                                </td>
                                <input type="hidden" name="linkman_bill">
                                <td class="table2_tr3_td2">
                                    <div id="linkman_bill_div">
                                        <%
                                            int len2 = linkmanList2.size();
                                            for (int i = 1; i < len2; i++) {
                                        %>
                                        <div class="div_padding" id="linkman_bill_div<%=i%>">
                                            姓名：<input type="text" value="<%=linkmanList2.get(i).getLinkman() %>"
                                                      id="linkman_bill<%=i %>" maxlength="10"
                                                      onkeydown="if(event.keyCode==32) return false">
                                            电话：<input type="phone" value="<%=linkmanList2.get(i).getPhone() %>"
                                                      id="phone_bill<%=i %>" maxlength="20"
                                                      onkeydown="if(event.keyCode==32) return false">
                                            <img src="images/delete.png" title="删除" onclick="delLinkman(2,<%=i %>);">
                                            <span id="linkman_bill_span<%=i %>"></span>
                                        </div>
                                        <%} %>
                                    </div>
                                    <div id="linkman_bill_div0" class="div_padding">
                                        姓名：<input type="text" id="linkman_bill0" maxlength="10"
                                                  value="<%=linkmanList2.size()>0?linkmanList2.get(0).getLinkman():"" %>"
                                                  onkeydown="if(event.keyCode==32) return false">
                                        电话：<input type="phone" id="phone_bill0" maxlength="20"
                                                  value="<%=linkmanList2.size()>0?linkmanList2.get(0).getPhone():"" %>"
                                                  onkeydown="if(event.keyCode==32) return false">
                                        <img src="images/delete.png" title="删除" onclick="delLinkman(2,0);">
                                        <img src="images/add_linkman.png" style="margin-left: 10px" title="添加"
                                             onclick="addLinkman(2);">
                                        <span id="linkman_bill_span0" style="margin-left: 10px"></span>
                                    </div>
                                </td>
                            </tr>
                            <% } %>

                            <tr class="table2_tr4">
                                <td class="table2_tr4_td1">
                                    <span class='star'>*</span>设备接收人
                                </td>
                                <input type="hidden" name="linkman_device">
                                <td class="table2_tr4_td2" id="linkman_device_td">
                                    <div id="linkman_device_div">
                                        <%
                                            int len3 = linkmanList3.size();
                                            for (int i = 1; i < len3; i++) {
                                        %>
                                        <div class="div_padding" id="linkman_device_div<%=i%>">
                                            姓名：<input type="text" value="<%=linkmanList3.get(i).getLinkman() %>"
                                                      id="linkman_device<%=i %>" maxlength="10"
                                                      onkeydown="if(event.keyCode==32) return false">
                                            电话：<input type="phone" value="<%=linkmanList3.get(i).getPhone() %>"
                                                      id="phone_device<%=i %>" maxlength="20"
                                                      onkeydown="if(event.keyCode==32) return false">
                                            <img src="images/delete.png" title="删除" onclick="delLinkman(3,<%=i %>);">
                                            <span id="linkman_device_span<%=i %>"></span>
                                        </div>
                                        <%} %>
                                    </div>
                                    <div id="linkman_device_div0" class="div_padding">
                                        姓名：<input type="text" id="linkman_device0" maxlength="10"
                                                  value="<%=linkmanList3.size()>0?linkmanList3.get(0).getLinkman():"" %>"
                                                  onkeydown="if(event.keyCode==32) return false">
                                        电话：<input type="phone" id="phone_device0" maxlength="20"
                                                  value="<%=linkmanList3.size()>0?linkmanList3.get(0).getPhone():"" %>"
                                                  onkeydown="if(event.keyCode==32) return false">
                                        <img src="images/delete.png" title="删除" onclick="delLinkman(3,0);">
                                        <img src="images/add_linkman.png" style="margin-left: 10px" title="添加"
                                             onclick="addLinkman(3);">
                                        <span id="linkman_device_span0" style="margin-left: 10px"></span>
                                    </div>
                                </td>
                            </tr>
                            <tr class="table2_tr5">
                                <td class="table2_tr5_td1">
                                    <span class='star'>*</span>要求发货时间
                                </td>
                                <td class="table2_tr5_td2">
                                    <input type="text" id="time" name="delivery_time"
                                           value="<%=task.getDelivery_timestr()%>"
                                           onClick="return Calendar('time');" readonly="readonly"/>
                                    <span id="time_error"></span>
                                </td>
                            </tr>
                            <tr class="table2_tr1">
                                <td class="table2_tr1_td1">
                                    <span class='star'>*</span>预计发货地址
                                </td>
                                <td class="table2_tr1_td2">
                                    <input type="text" id="address" name="address"
                                           value="<%= task.getAddress()!=null ? task.getAddress():""%>" maxlength="200">
                                    <span id="address_error"></span>
                                </td>
                            </tr>

                            <tr class="table2_tr1">
                                <td class="table2_tr1_td1">
                                    <span class='star'>*</span>收货人
                                </td>
                                <td class="table2_tr1_td2">
                                    <input type="text" name="consignee"
                                           value="<%=task.getConsignee()!=null ? task.getConsignee():""%>"
                                           maxlength="200">
                                    <span id="consignee_error"></span>
                                </td>
                            </tr>


                            <tr class="table2_tr6">
                                <td class="table2_tr6_td1">
                                    <span class='star'>*</span>项目说明及<br/>特殊要求
                                </td>
                                <td class="table2_tr6_td2">
                                    <span>1.是否要求施工前现场开箱验货&nbsp</span>
                                    <label><input name="inspection" type="radio"
                                                  value="0" <%=task.getInspection() == 0 ? "checked" : ""%>/>是</label>
                                    <label><input name="inspection" type="radio"
                                                  value="1" <%=task.getInspection() == 1 ? "checked" : ""%>/>否</label><br/>
                                    <span>2.发货前是否要求需和销售经理确认&nbsp</span>
                                    <label><input name="verify" type="radio"
                                                  value="0" <%=task.getVerify() == 0 ? "checked" : ""%>/>是</label>
                                    <label><input name="verify" type="radio"
                                                  value="1" <%=task.getVerify() == 1 ? "checked" : ""%>/>否</label><br/>
                                    <div><%=DataUtil.getTask_Desc()%>
                                    </div>
                                    <textarea name="description" placeholder="此处输入项目说明和特殊要求"
                                              onkeydown="limitLength(this,1800);" onkeyup="limitLength(this,1800);"
                                              maxlength="1800"><%=task.getDescription().length() > 0 ? task.getDescription() : "" %></textarea>
                                </td>
                            </tr>
                            <tr class="table2_tr7">
                                <td class="table2_tr7_td1">
                                    <span class='star'>*</span>供货清单
                                </td>
                                <td class="table2_tr7_td2">
                                    <div class="tr7_div1">
                                        <%
                                            for (File_path file_path : fpathList1) {
                                        %>
                                        <div id="file_div<%=file_path.getId()%>"><a class="img_a"
                                                                                    href="javascript:void()"
                                                                                    onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%>
                                        </a>
                                            [<a class="img_a" href="javascript:void(0);"
                                                onclick="delFile(<%=file_path.getId()%>,'<%=file_path.getFile_name()%>',1)">删除</a>]
                                        </div>
                                        <%
                                            }
                                        %>

                                    </div>
                                    <div class="tr7_div2">
                                        <div id="section4" class="section-white6">
                                            <input type="file" name="file_list" id="file_input1"
                                                   multiple="multiple">
                                        </div>
                                        <div class="section-white2">
                                            <span id="file_input1_error"></span>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr class="table2_tr8">
                                <td class="table2_tr8_td1">
                                    <span class='star'>*</span>移交项目中心<br/>技术附件
                                </td>
                                <td class="table2_tr8_td2">
                                    <div class="tr7_div1">
                                        <%
                                            if (task.getProtocol() == 0) {
                                                for (File_path file_path : fpathList2) {
                                        %>
                                        <div id="file_div<%=file_path.getId()%>"><a class="img_a"
                                                                                    href="javascript:void()"
                                                                                    onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%>
                                        </a>
                                            [<a class="img_a" href="javascript:void(0);"
                                                onclick="delFile(<%=file_path.getId()%>,'<%=file_path.getFile_name()%>',2)">删除</a>]
                                        </div>
                                        <%
                                                }
                                            }
                                        %>
                                    </div>
                                    <div class="tr7_div2">
                                        <div id="section5" class="section-white6">
                                            <input type="file" name="file_technical" id="file_input2"
                                                   multiple="multiple">
                                        </div>
                                        <div class="section-white2">
                                            <span id="file_input2_error"></span>
                                        </div>
                                    </div>
                                    <textarea name="other" placeholder="如：注明风机台数"
                                              onkeydown="limitLength(this,500);" onkeyup="limitLength(this,500);"
                                              maxlength="500"><%=task.getOther().length() > 0 ? task.getOther() : "" %></textarea>
                                </td>
                            </tr>
                            <tr class="table2_tr9">
                                <td class="table2_tr9_td1">
                                    备注
                                </td>

                                <td class="table2_tr9_td2" style="text-align: left;">
											<textarea name="remarks" onkeydown="limitLength(this,2000);"
                                                      onkeyup="limitLength(this,2000);"
                                                      placeholder="此处输入备注" required="required"
                                                      maxlength="2000"><%=task.getRemarks() != null ? task.getRemarks() : ""%></textarea>
									<%
										if(fpathList6!=null && fpathList6.size()!=0){
											for (File_path file_path : fpathList6) {
									%>
									<div class="state_div" style="display: inline-block;line-height: 25px;color: #ff9999;border-radius: 3px;
																	font-size: 13px;text-align: center;font-family: 'microsoft yahei';margin-right: 20px;cursor: pointer;">
										<span>
											<%=DateTrans.transitionDate(file_path.getCreate_time())%>
										</span>
									</div>
									<div>
										<a class="img_a" href="javascript:void()"
										   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%>
										</a>
									</div>
									<%
											}
										}
									%>

									<div id="section4" class="div_file_right_div">
										<input type="file" name="file_list" id="file_input6"
											   multiple="multiple">
									</div>
									<div class="state_add">
										<div class="save_div" style="display:none">添加附件</div>
										<div style="display: inline-block;line-height: 25px;color: #ff9999;border-radius: 3px;width: 80px;color: #fff;margin-top: 10px;
																	font-size: 13px;text-align: center;font-family: 'microsoft yahei';margin-right: 20px;cursor: pointer;background: #43C753" class="submit_div" onclick="saveTaskFile6()">保存</div>
									</div>
                                </td>
                            </tr>

                        </table>
                        <%if (operation > 2 && operation != 5 && operation != 8) { %>
                        <textarea name="reason" id="reason" class="div_testarea" placeholder="请输入修改内容"
                                  required="required" maxlength="500"></textarea>

                        <%} %>
                        <div class="div_btn"><img src="images/submit_flow.png" onclick="alertFlow();"></div>
                    </div>
                </form>
            </td>
        </tr>
    </table>

</div>
</body>
</html>
