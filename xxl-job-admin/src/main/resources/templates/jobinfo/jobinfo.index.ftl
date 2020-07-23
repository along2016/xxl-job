<!DOCTYPE html>
<html>
<head>
  	<#import "../common/common.macro.ftl" as netCommon>
	<@netCommon.commonStyle />
	<!-- DataTables -->
  	<link rel="stylesheet" href="${request.contextPath}/static/adminlte/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
    <title>${I18n.admin_name}</title>
</head>
<body class="hold-transition skin-blue sidebar-mini <#if cookieMap?exists && cookieMap["xxljob_adminlte_settings"]?exists && "off" == cookieMap["xxljob_adminlte_settings"].value >sidebar-collapse</#if>">
<div class="wrapper">
	<!-- header -->
	<@netCommon.commonHeader />
	<!-- left -->
	<@netCommon.commonLeft "jobinfo" />
	
	<div class="content-wrapper">
		<!-- Content Header (Page header) -->
		<section class="content-header">
			<h1>${I18n.job_info_name}</h1>
		</section>
		
		<!-- Main content -->
	    <section class="content">
	    	<div class="row">
	    		<div class="col-xs-3">
	              	<div class="input-group">
	                	<span class="input-group-addon">${I18n.job_info_field_job_group}</span>
                		<select class="form-control" id="jobGroup" >
                			<#list JobGroupList as group>
                				<option value="${group.id}" <#if jobGroup==group.id>selected</#if> >${group.title}</option>
                			</#list>
	                  	</select>
	              	</div>
	            </div>
                <div class="col-xs-1">
                    <div class="input-group">
                        <select class="form-control" id="triggerStatus" >
                            <option value="-1">${I18n.system_all}</option>
                            <option value="0">${I18n.job_info_opt_stop}</option>
                            <option value="1">${I18n.job_info_opt_start}</option>
                        </select>
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="input-group">
                        <input type="text" class="form-control" id="jobDesc" autocomplete="on"
                               placeholder="${I18n.system_please_input}${I18n.job_info_field_job_desc}" >
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="input-group">
                        <input type="text" class="form-control" id="executorHandler" autocomplete="on" placeholder="${I18n.system_please_input}JobHandler" >
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="input-group">
                        <input type="text" class="form-control" id="author" autocomplete="on" placeholder="${I18n.system_please_input}${I18n.job_info_field_author}" >
                    </div>
                </div>
	            <div class="col-xs-1">
	            	<button class="btn btn-block btn-info" id="searchBtn">${I18n.system_search}</button>
	            </div>
	            <div class="col-xs-1">
	            	<button class="btn btn-block btn-success add" type="button">${I18n.job_info_field_add}</button>
	            </div>
          	</div>
	    	
			<div class="row" style="margin-top: 10px;">
				<div class="col-xs-12">
					<div class="box">
			            <div class="box-body" >
			              	<table id="job_list" class="table table-bordered table-striped" width="100%" >
				                <thead>
					            	<tr>
					            		<th name="id" >${I18n.job_info_field_id}</th>
					                	<th name="jobGroup" >${I18n.job_info_field_job_group}</th>
					                  	<th name="jobDesc" >${I18n.job_info_field_job_desc}</th>
                                        <th name="glueType" >${I18n.job_info_field_glue_type}</th>
					                  	<th name="executorParam" >${I18n.job_info_field_executor_param}</th>
                                        <th name="jobCron" >Cron</th>
					                  	<th name="addTime" >addTime</th>
					                  	<th name="updateTime" >updateTime</th>
					                  	<th name="author" >${I18n.job_info_field_author}</th>
					                  	<th name="alarmEmail" >${I18n.job_info_field_alarm_email}</th>
					                  	<th name="triggerStatus" >${I18n.system_status}</th>
					                  	<th>${I18n.system_opt}</th>
					                </tr>
				                </thead>
				                <tbody></tbody>
				                <tfoot></tfoot>
							</table>
						</div>
					</div>
				</div>
			</div>
	    </section>
	</div>
	
	<!-- footer -->
	<@netCommon.commonFooter />
</div>

<!-- job新增.模态框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
            	<h4 class="modal-title" >${I18n.job_info_field_add}</h4>
         	</div>
         	<div class="modal-body">
				<form class="form-horizontal form" role="form" >
					<div class="form-group">
						<label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_job_group}<font color="red">*</font></label>
						<div class="col-sm-4">
							<select class="form-control" name="jobGroup" >
		            			<#list JobGroupList as group>
		            				<option value="${group.id}" <#if jobGroup==group.id>selected</#if> >${group.title}</option>
		            			</#list>
		                  	</select>
						</div>
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_job_desc}<font color="red">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="jobDesc" placeholder="${I18n.system_please_input}${I18n.job_info_field_job_desc}" maxlength="50" ></div>
					</div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_executorRouteStrategy}<font color="red">*</font></label>
                        <div class="col-sm-4">
                            <select class="form-control" name="executorRouteStrategy" >
							<#list ExecutorRouteStrategyEnum as item>
                                <option value="${item}" >${item.title}</option>
							</#list>
                            </select>
                        </div>
                        <label for="lastname" class="col-sm-2 control-label">Cron<font color="red">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="jobCron" placeholder="${I18n.system_please_input}Cron" maxlength="128" ></div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_glue_type}<font color="red">*</font></label>
                        <div class="col-sm-4">
                            <select class="form-control glueType" name="glueType" >
								<#list GlueTypeEnum as item>
									<option value="${item}" >${item.desc}</option>
								</#list>
                            </select>
                        </div>
                        <label for="firstname" class="col-sm-2 control-label">JobHandler<font color="red">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="executorHandler" placeholder="${I18n.system_please_input}JobHandler" maxlength="100" ></div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_executorBlockStrategy}<font color="red">*</font></label>
                        <div class="col-sm-4">
                            <select class="form-control" name="executorBlockStrategy" >
								<#list ExecutorBlockStrategyEnum as item>
                                    <option value="${item}" >${item.title}</option>
                                </#list>
                            </select>
                        </div>
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_childJobId}<font color="black">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="childJobId" placeholder="${I18n.job_info_field_childJobId_placeholder}" maxlength="100" ></div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_timeout}<font color="black">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="executorTimeout" placeholder="${I18n.job_info_field_executorTimeout_placeholder}" maxlength="6" ></div>
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_executorFailRetryCount}<font color="black">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="executorFailRetryCount" placeholder="${I18n.job_info_field_executorFailRetryCount_placeholder}" maxlength="4" ></div>
                    </div>
					<div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_author}<font color="red">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="author" placeholder="${I18n.system_please_input}${I18n.job_info_field_author}" maxlength="50" ></div>
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_alarm_email}<font color="black">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="alarmEmail" placeholder="${I18n.job_info_field_alarm_email}" maxlength="100" ></div>
					</div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_executor_param}<font color="black">*</font></label>
                        <div class="col-sm-10">
                            <textarea class="textarea form-control" name="executorParam" placeholder="${I18n.system_please_input}${I18n.job_info_field_executor_param}" maxlength="512" style="height: 63px; line-height: 1.2;"></textarea>
						</div>
                    </div>

                    <hr>
					<div class="form-group">
						<div class="col-sm-offset-3 col-sm-6">
							<button type="submit" class="btn btn-primary"  >${I18n.system_save}</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">${I18n.system_cancel}</button>
						</div>
					</div>

<input type="hidden" name="glueRemark" value="GLUE代码初始化" >
<textarea name="glueSource" style="display:none;" ></textarea>
<textarea class="glueSource_java" style="display:none;" >
package com.xxl.job.service.handler;

import com.xxl.job.core.log.XxlJobLogger;
import com.xxl.job.core.biz.model.ReturnT;
import com.xxl.job.core.handler.IJobHandler;

public class DemoGlueJobHandler extends IJobHandler {

	@Override
	public ReturnT<String> execute(String param) throws Exception {
		XxlJobLogger.log("XXL-JOB, Hello World.");
		return ReturnT.SUCCESS;
	}

}
</textarea>
<textarea class="glueSource_shell" style="display:none;" >
#!/bin/bash
echo "xxl-job: hello shell"

echo "${I18n.job_info_script_location}：$0"
echo "${I18n.job_info_field_executor_param}：$1"
echo "${I18n.job_info_shard_index} = $2"
echo "${I18n.job_info_shard_total} = $3"
<#--echo "参数数量：$#"
for param in $*
do
    echo "参数 : $param"
    sleep 1s
done-->

echo "Good bye!"
exit 0
</textarea>
<textarea class="glueSource_python" style="display:none;" >
#!/usr/bin/python
# -*- coding: UTF-8 -*-
import time
import sys

print "xxl-job: hello python"

print "${I18n.job_info_script_location}：", sys.argv[0]
print "${I18n.job_info_field_executor_param}：", sys.argv[1]
print "${I18n.job_info_shard_index}：", sys.argv[2]
print "${I18n.job_info_shard_total}：", sys.argv[3]

print "Good bye!"
exit(0)
</textarea>
<#--这里有问题，新建一个运行模式为 php 的任务后，GLUE 中没有下边的 php 代码-->
<textarea class="glueSource_php" style="display:none;" >
<?php

    echo "xxl-job: hello php  \n";

    echo "${I18n.job_info_script_location}：$argv[0]  \n";
    echo "${I18n.job_info_field_executor_param}：$argv[1]  \n";
    echo "${I18n.job_info_shard_index} = $argv[2]  \n";
    echo "${I18n.job_info_shard_total} = $argv[3]  \n";

    echo "Good bye!  \n";
    exit(0);

?>
</textarea>
<textarea class="glueSource_nodejs" style="display:none;" >
#!/usr/bin/env node
console.log("xxl-job: hello nodejs")

var arguments = process.argv

console.log("${I18n.job_info_script_location}: " + arguments[1])
console.log("${I18n.job_info_field_executor_param}: " + arguments[2])
console.log("${I18n.job_info_shard_index}: " + arguments[3])
console.log("${I18n.job_info_shard_total}: " + arguments[4])

console.log("Good bye!")
process.exit(0)
</textarea>
<textarea class="glueSource_powershell" style="display:none;" >
Write-Host "xxl-job: hello powershell"

Write-Host "${I18n.job_info_script_location}: " $MyInvocation.MyCommand.Definition
Write-Host "${I18n.job_info_field_executor_param}: "
	if ($args.Count -gt 2) { $args[0..($args.Count-3)] }
Write-Host "${I18n.job_info_shard_index}: " $args[$args.Count-2]
Write-Host "${I18n.job_info_shard_total}: " $args[$args.Count-1]

Write-Host "Good bye!"
exit 0
</textarea>
				</form>
         	</div>
		</div>
	</div>
</div>

<!-- 更新.模态框 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog"  aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
            	<h4 class="modal-title" >${I18n.job_info_field_update}</h4>
         	</div>
         	<div class="modal-body">
				<form class="form-horizontal form" role="form" >
					<div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_job_group}<font color="red">*</font></label>
                        <div class="col-sm-4">
                            <select class="form-control" name="jobGroup" >
							<#list JobGroupList as group>
                                <option value="${group.id}" >${group.title}</option>
							</#list>
                            </select>
                        </div>
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_job_desc}<font color="red">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="jobDesc" placeholder="${I18n.system_please_input}${I18n.job_info_field_job_desc}" maxlength="50" ></div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_executorRouteStrategy}<font color="red">*</font></label>
                        <div class="col-sm-4">
                            <select class="form-control" name="executorRouteStrategy" >
							<#list ExecutorRouteStrategyEnum as item>
                                <option value="${item}" >${item.title}</option>
							</#list>
                            </select>
                        </div>
                        <label for="lastname" class="col-sm-2 control-label">Cron<font color="red">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="jobCron" placeholder="${I18n.system_please_input}Cron" maxlength="128" ></div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_glue_type}<font color="red">*</font></label>
                        <div class="col-sm-4">
                            <select class="form-control glueType" name="glueType" disabled >
							<#list GlueTypeEnum as item>
                                <option value="${item}" >${item.desc}</option>
							</#list>
                            </select>
                        </div>
                        <label for="firstname" class="col-sm-2 control-label">JobHandler<font color="red">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="executorHandler" placeholder="${I18n.system_please_input}JobHandler" maxlength="100" ></div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_executorBlockStrategy}<font color="red">*</font></label>
                        <div class="col-sm-4">
                            <select class="form-control" name="executorBlockStrategy" >
							<#list ExecutorBlockStrategyEnum as item>
                                <option value="${item}" >${item.title}</option>
							</#list>
                            </select>
                        </div>
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_childJobId}<font color="black">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="childJobId" placeholder="${I18n.job_info_field_childJobId_placeholder}" maxlength="100" ></div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_timeout}<font color="black">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="executorTimeout" placeholder="${I18n.job_info_field_executorTimeout_placeholder}" maxlength="6" ></div>
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_executorFailRetryCount}<font color="black">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="executorFailRetryCount" placeholder="${I18n.job_info_field_executorFailRetryCount_placeholder}" maxlength="4" ></div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_author}<font color="red">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="author" placeholder="${I18n.system_please_input}${I18n.job_info_field_author}" maxlength="50" ></div>
                        <label for="lastname" class="col-sm-2 control-label">${I18n.job_info_field_alarm_email}<font color="black">*</font></label>
                        <div class="col-sm-4"><input type="text" class="form-control" name="alarmEmail" placeholder="${I18n.job_info_field_alarm_email_placeholder}" maxlength="100" ></div>
                    </div>
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_executor_param}<font color="black">*</font></label>
                        <div class="col-sm-10">
                            <textarea class="textarea form-control" name="executorParam" placeholder="${I18n.system_please_input}${I18n.job_info_field_executor_param}" maxlength="512" style="height: 63px; line-height: 1.2;"></textarea>
						</div>
                    </div>

					<hr>
					<div class="form-group">
                        <div class="col-sm-offset-3 col-sm-6">
							<button type="submit" class="btn btn-primary"  >${I18n.system_save}</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">${I18n.system_cancel}</button>
                            <input type="hidden" name="id" >
						</div>
					</div>

				</form>
         	</div>
		</div>
	</div>
</div>

<#-- trigger -->
<div class="modal fade" id="jobTriggerModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog ">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" >${I18n.job_info_opt_run}</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal form" role="form" >
                    <div class="form-group">
                        <label for="firstname" class="col-sm-2 control-label">${I18n.job_info_field_executor_param}<font color="black">*</font></label>
                        <div class="col-sm-10">
                            <textarea class="textarea form-control" name="executorParam"
                                      placeholder="${I18n.system_please_input}${I18n.job_info_field_executor_param}"
                                      maxlength="512" style="height: 63px; line-height: 1.2;"></textarea>
                        </div>
                    </div>
                    <hr>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-6">
                            <button type="button" class="btn btn-primary ok" >${I18n.system_save}</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">${I18n.system_cancel}</button>
                            <input type="hidden" name="id" >
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<@netCommon.commonScript />
<!-- DataTables -->
<script src="${request.contextPath}/static/adminlte/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${request.contextPath}/static/adminlte/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<!-- moment -->
<script src="${request.contextPath}/static/adminlte/bower_components/moment/moment.min.js"></script>
<#-- cronGen -->
<script src="${request.contextPath}/static/plugins/cronGen/cronGen.js"></script>
<script src="${request.contextPath}/static/js/jobinfo.index.1.js"></script>
</body>
</html>
