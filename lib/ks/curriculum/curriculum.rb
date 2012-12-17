#!/usr/bin/env ruby

# 
# == Synopsis
#
# Organization class containing all operations around curriculum objects
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

class Curriculum
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
    
  # Load curriculum homepage
  def homepage
            
  end
  
  
  # Create a proposal
  # TODO: Org ID is hardcoded to Fisheries Department in requests, need to use dyn_variable
  #
  # Option: DEFAULT_VALUE
  # * 'mode': 'blank'
  def create_proposal(title, oversight_department, admin_org, opts={})
    
    lo_cat = "Scientific method"
    lo_cat_text = "LO Cat Text"
    
    defaults = {
      :propose_person => '%%_username%%', #user is the dynvar from users.csv
      :mode => 'blank',
      :nav_homepage => true,
      :submit => true,
      :append_unique_id => false, #tell tsung to append unique id on title
      :instructor => 'fred', #BUG - HARDCODED - can't use dynvar though because of ajax search
      :instructor_id_var_name => "instructor_id_var_name",
      :instructor_id_var_regexp => '([^\"]+)\"\,\"personId',
      :collaborator => @request.config.directory["users"]["collaborator"]["username"],
      :first_expected_offering => @request.config.directory["atp"]["name"],
      :subject_area => "BSCI",
      :oversight_dept_number => "65", #BUG - right now hardcoded to BSCI, search that returned this was removed
      :course_suffix => "123",
      :course_short_title => "Perf Course",
      :course_title => title,
      :proposal_title => title,
      :course_description => "My fake description.",
      :course_rationale => "My fake rationale.",
      :lo_create => FALSE,
      :lo_category => lo_cat,
      :lo_cat_text => lo_cat_text,
      :lo_name => @request.config.directory["lo"]["name"],
      :admin_dep_var_name => "admin_dep_org_id",
      :admin_dep_var_regexp => 'org.resultColumn.orgId\"\,\"([^\"]+)',
      :proposal_dyn_var_name => "proposal_id",
      :proposal_dyn_var_regexp => '\"proposal\"\,\"workflowNode\"\,\"PreRoute\"\,\"([^\"]+)',
      :proposal_doc_id_var_name => "proposal_doc_id",
      :proposal_doc_id_var_regexp => 'workflowId\"\,\"([^\"]+)\"',
      :clu_ref_dyn_var_name => "clu_ref_id",
      :clu_ref_dyn_var_regexp => '\"id\"\,\"([^\"]+)',
      :result_com_var_name => "result_component_id",
      :result_com_var_regexp => '\"ResultComponent 1\"\,\"([^\"]+)',
      :enroll_est_var_name => "default_enrollment_estimate_id",
      :enroll_est_var_regexp => 'defaultEnrollmentEstimate\"\,\"kuali.atp.duration.Week\"\,\"Week\"\,\"id\"\,\"([^\"]+)',
      :lab_var_name => "lab_id",
      :lab_var_regexp => '\"unitsContentOwner\"\,\"Lab\"\,\"([^\"]+)',
      :lab_fee_id_name => 'cp_lab_fee_id',
      :lab_fee_id_regexp => 'kuali.enum.type.feeTypes.labFee\"\,\"([^\"]+)',
      :revenues_id_name => 'cp_revenues_id',
      :revenues_id_regexp => 'revenues\"\,\"([^\"]+)',
      :revenue_id_name => 'cp_revenue_id',
      :revenue_id_regexp => 'REVENUE\"\,\"([^\"]+)',
      :joints_var_name => "joints_num",
      :joints_var_regexp => 'joints\"\,\"[^\"]+\"\,\"([^\"]+)',
      :fee_info_id_dyn_var_name => 'fee_info_id',
      :fee_info_id_dyn_var_regexp => '\"fees\"\,\"([^\"]+)',
      :fee_info_dyn_var_name => 'fee_info',
      :fee_info_dyn_var_regexp => 'org.kuali.student.lum.lu.dto.CluFeeInfo\"\,\"([^\"]+)',
      :clu_info_dyn_var_name => 'clu_info',
      :clu_info_dyn_var_regexp => 'org.kuali.student.lum.lu.dto.CluInfo\"\,\"([^\"]+)',
      :lu_dto_clu_format_dyn_var_name => "lu_dto_clu_format",
      :lu_dto_clu_format_dyn_var_regexp => 'org.kuali.student.lum.lu.dto.CluInfo\"\,\"Credit Course\"\,\"[^\"]+\"\,\"formats\"\,\"([^\"]+)',
      :lu_dto_clu_activities_dyn_var_name => "lu_dto_clu_activites",
      :lu_dto_clu_activities_dyn_var_regexp => 'org.kuali.student.lum.lu.dto.CluInfo\"\,\"Credit Course\"\,\"[^\"]+\"\,\"formats\"\,\"[^\"]+\"\,\"0\"\,\"activities\"\,\"([^\"]+)',
      :outcome_id_var_name => "outcome_id",
      :outcome_id_var_regexp => 'outcomeId\"\,\"([^\"]+)',
      :lo_category_var_name => "lo_category",
      :lo_category_var_regexp => lo_cat_text + '\"\,\"plain\"\,\"([^\"]+)',
      :lo_category_id_var_name => "lo_category_id",
      :lo_category_id_var_regexp => 'lo.resultColumn.categoryId"\,\"([^\"]+)',
      :lo_child_id_dyn_var_name => "lo_child_id",
      :lo_child_id_dyn_var_regexp => 'childLo\"\,\"([^\"]+)',
      :single_use_lo_dyn_var_name => "single_use_lo",
      :single_use_lo_dyn_var_regexp => 'includedSingleUseLo\"\,\"([^\"]+)',
      :atp_duration_week_var_name => 'atp_duration_week',
      :atp_duration_week_var_regexp => 'kuali.atp.duration.Week\"\,\"Week\"\,\"id\"\,\"([^\"]+)',
      :version_ind_id_name => 'cp_version_ind_id',
      :version_ind_id_regexp => 'versionIndId\"\,\"([^\"]+)',
      :affliated_orgs_id_name => 'cp_affiliated_orgs_id',
      :affliated_orgs_id_regexp => 'affiliatedOrgs\"\,\"([^\"]+)',
      :action_request_id_name => 'cp_action_request_id',
      :action_request_id_regexp => 'actionRequestId\"\,\"([^\"]+)'
    }
    
    # Version for the doc at each step. We'll increment on each usage
    # So first usage should eval to 0
    version_indicator = -1
    
    opts = defaults.merge(opts)
    
    title << '_%%ts_user_server:get_unique_id%%' if(opts[:append_unique_id])
    
    if(opts[:mode] != "blank")
      # select template or copy course...
    end
    
    # Navigate to Curriculum Mgmt
    self.homepage() unless(!opts[:nav_homepage])
    
    puts "creating proposal as: #{opts[:propose_person]}"
    
    # Click Create a course
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|9509131F618790C2E81D1739D6743235|org.kuali.student.common.ui.client.service.SecurityRpcService|hasScreenPermission|java.lang.String/2004016611|useCurriculumReview|1|2|3|4|1|5|6|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    # In the "Create a Course" popup:
    # Make sure only "Start a blank proposal" is selected and click "Start Proposal"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|isAuthorized|org.kuali.student.r1.common.rice.authorization.PermissionType/3661700771|java.util.Map|java.util.HashMap/1797211028|1|2|3|4|2|5|6|5|0|7|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|15|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|getMetadata|java.lang.String/2004016611|java.util.Map||java.util.HashMap/1797211028|documentTypeName|kuali.proposal.type.course.create|DtoState|Draft|DtoNextState|DtoWorkflowNode|PreRoute|1|2|3|4|2|5|6|7|8|4|5|9|5|10|5|11|5|12|5|13|5|7|5|14|5|15|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|ABC7A51BAB09732A2470B566E5316DE9|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|0|6|0|7|8|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|atp.search.atpDurationTypes|atp.resultColumn.atpDurTypeName|1|2|3|4|1|5|5|0|0|0|6|0|7|8|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lrc.queryParam.resultComponent.type|java.lang.String/2004016611|kuali.result.values.group.type.multiple|kuali.result.values.group.type.range|kuali.result.values.group.type.fixed|lrc.queryParam.resultComponent.idRestrictionList|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|0|6|2|7|0|8|6|3|9|10|9|11|9|12|7|0|13|6|5|9|14|9|15|9|16|9|17|9|18|19|20|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.finalExam.status|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.result.values.group.type.fixed|kuali.result.values.group.type.range|kuali.result.values.group.type.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|3|9|10|9|11|9|12|13|14|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.result.values.group.type.fixed|kuali.result.values.group.type.range|kuali.result.values.group.type.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|3|9|10|9|11|9|12|13|14|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.result.values.group.type.fixed|kuali.result.values.group.type.range|kuali.result.values.group.type.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|3|9|10|9|11|9|12|13|14|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|0|6|0|7|8|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|0|6|0|7|8|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lrc.queryParam.resultComponent.type|java.lang.String/2004016611|kuali.result.values.group.type.multiple|kuali.result.values.group.type.range|kuali.result.values.group.type.fixed|lrc.queryParam.resultComponent.idRestrictionList|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|0|6|2|7|0|8|6|3|9|10|9|11|9|12|7|0|13|6|5|9|14|9|15|9|16|9|17|9|18|19|20|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lrc.queryParam.resultComponent.type|java.lang.String/2004016611|kuali.result.values.group.type.multiple|kuali.result.values.group.type.range|kuali.result.values.group.type.fixed|lrc.queryParam.resultComponent.idRestrictionList|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|0|6|2|7|0|8|6|3|9|10|9|11|9|12|7|0|13|6|5|9|14|9|15|9|16|9|17|9|18|19|20|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CommentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|C520149EEE36D5B4C7BC350FB310CE2D|org.kuali.student.core.comments.ui.client.service.CommentRpcService|getUserRealName|java.lang.String/2004016611|#{opts[:propose_person]}|1|2|3|4|1|5|6|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|subjectCode.queryParam.code|java.lang.String/2004016611||subjectCode.search.orgsForSubjectCode|subjectCode.resultColumn.orgLongName|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintIdExclusive||atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|0|6|2|7|0|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|7|0|17|6|1|9|18|19|20|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|19|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|0|6|2|7|0|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|7|0|17|6|1|0|18|19|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    #
    # Pg1 - Course Information
    #

    # Click on Show all fields
    # Enter all required fields

    @request.add_thinktime(5)

    # Course Subject Code
    # AJAX popup while typing in subject area
    for i in 1..opts[:subject_area].length
      itr = i-1
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|13|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|subjectCode.queryParam.code|java.lang.String/2004016611|#{opts[:subject_area][0..itr]}|subjectCode.search.subjectCodeGeneric|subjectCode.resultColumn.code|1|2|3|4|1|5|5|0|0|6|0|7|1|8|0|9|7|1|10|11|12|13|0|0|"
        },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }                           
    )
    end
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|subjectCode.queryParam.code|java.lang.String/2004016611|#{opts[:subject_area]}|subjectCode.search.orgsForSubjectCode|subjectCode.resultColumn.orgLongName|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }                        
    )

    @request.add_thinktime(3)

    # Instructor
    # fred
    for i in 1..opts[:instructor].length
      itr = i-1
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|person.queryParam.personGivenName|java.lang.String/2004016611|#{opts[:instructor][0..itr]}|person.search.personQuickViewByGivenName|person.resultColumn.DisplayName|org.kuali.student.r2.core.search.dto.SortDirection/4233948822|1|2|3|4|1|5|5|0|0|6|0|7|1|8|0|9|7|1|10|11|12|13|14|0|0|"
      },
      { 
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }                             
      )        
    end


    @request.add_thinktime(22)

    # Save & Continue
    contents1 = "7|0|40|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.r1.common.assembly.data.Data/1485826496|org.kuali.student.r1.common.assembly.data.Data|java.util.LinkedHashMap/3008245022|org.kuali.student.r1.common.assembly.data.Data$StringKey/642388540|proposal|org.kuali.student.r1.common.assembly.data.Data$DataValue/690845158|type|org.kuali.student.r1.common.assembly.data.Data$StringValue/223926985|kuali.proposal.type.course.create|workflowNode|PreRoute|name|#{opts[:proposal_title]}|_runtimeData|dirty|org.kuali.student.r1.common.assembly.data.Data$BooleanValue/2980665104|java.lang.Boolean/476441737|rationale|plain|#{opts[:course_rationale]}|courseTitle|transcriptTitle|subjectArea|courseNumberSuffix|instructors|#{opts[:course_short_title]}|#{opts[:subject_area]}|#{opts[:course_suffix]}|org.kuali.student.r1.common.assembly.data.Data$IntegerKey/2963918776|java.lang.Integer/3438268394|personId|#{opts[:instructor]}|id-translation|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|descr|#{opts[:course_description]}"
    contents2 = "|1|2|3|4|1|5|5|6|7|0|8|8|9|10|5|6|7|0|5|8|11|12|13|8|14|12|15|8|16|12|17|8|18|10|5|6|7|0|1|8|19|10|5|6|7|0|1|-11|20|21|1|-15|-17|-5|-13|8|22|10|5|6|7|0|2|8|23|12|24|-13|10|5|6|7|0|1|-17|10|5|6|7|0|1|-27|20|-22|-30|-17|-25|-13|-5|-23|-1|-3|8|25|12|17|-13|10|5|6|7|0|1|-17|10|5|6|7|0|5|-36|20|-22|8|26|20|-22|8|27|20|-22|8|28|20|-22|8|29|20|-22|-39|-17|-1|-13|-45|12|30|-47|12|31|-49|12|32|-51|10|5|6|7|0|1|33|34|0|10|5|6|7|0|2|8|35|12|36|8|18|10|5|6|7|0|1|8|35|10|5|6|7|0|1|8|37|12|38|-68|-70|-62|-66|-57|-59|-1|8|29|8|39|10|5|6|7|0|2|8|23|12|40|-13|10|5|6|7|0|1|-17|10|5|6|7|0|1|-81|20|-22|-84|-17|-79|-13|-1|-77|0|0|"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "#{contents1}#{contents2}"
      },
      {
        :dyn_variables => [
          {"name" => opts[:proposal_dyn_var_name], "re" => opts[:proposal_dyn_var_regexp]},
          {"name" => opts[:clu_ref_dyn_var_name], "re" => opts[:clu_ref_dyn_var_regexp]},
          {"name" => opts[:proposal_doc_id_var_name], "re" => opts[:proposal_doc_id_var_regexp]},
          {"name" => opts[:version_ind_id_name], "re" => opts[:version_ind_id_regexp]},
          {"name" => opts[:instructor_id_var_name], "re" => opts[:instructor_id_var_regexp]}
        ],
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    #@request.add("DEBUG/proposal_dyn_var_name/%%_#{opts[:proposal_dyn_var_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    #@request.add("DEBUG/clu_ref_dyn_var_name/%%_#{opts[:clu_ref_dyn_var_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    #@request.add("DEBUG/proposal_doc_id_var_name/%%_#{opts[:proposal_doc_id_var_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    #@request.add("DEBUG/version_ind_id_name/%%_#{opts[:version_ind_id_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
  
    
    #
    # Pg 2 - Governance
    # Campus Locations: All
    #

    # COC Org
    # Biology Dept

    @request.add_thinktime(8)

    #All Campus Locations
    # Admin Org
    # Botany
    for i in 1..admin_org.length
      itr = i-1
      if(i == admin_org.length)
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "7|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|org.queryParam.orgOptionalLongName|java.lang.String/2004016611|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|kuali.org.Department|kuali.org.College|org.search.generic|org.resultColumn.orgOptionalLongName|1|2|3|4|1|5|5|0|0|6|0|7|2|8|0|9|7|1|10|11|8|0|12|7|2|10|13|10|14|15|16|0|0|"
          },
          {
            :dyn_variables => [
              {"name" => opts[:admin_dep_var_name], "re" => opts[:admin_dep_var_regexp]}
            ],
            :custom_headers => {
              'X-GWT-Permutation' => "HostedMode"
            } 
          }
        )

        #@request.add("DEBUG/admin_dep_var_name/%%_#{opts[:admin_dep_var_name]}%%", {}, {'subst' => 'true'})

      else
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "7|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|org.queryParam.orgOptionalLongName|java.lang.String/2004016611|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|kuali.org.Department|kuali.org.College|org.search.generic|org.resultColumn.orgOptionalLongName|1|2|3|4|1|5|5|0|0|6|0|7|2|8|0|9|7|1|10|11|8|0|12|7|2|10|13|10|14|15|16|0|0|"
          },
          {
            :custom_headers => {
              'X-GWT-Permutation' => "HostedMode"}
          }    
        )
      end    
    end

    @request.add_thinktime(15)

    # Save & Continue
    contents1 = "7|0|104|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.r1.common.assembly.data.Data/1485826496|org.kuali.student.r1.common.assembly.data.Data|java.util.LinkedHashMap/3008245022|org.kuali.student.r1.common.assembly.data.Data$StringKey/642388540|campusLocations|org.kuali.student.r1.common.assembly.data.Data$DataValue/690845158|org.kuali.student.r1.common.assembly.data.Data$IntegerKey/2963918776|java.lang.Integer/3438268394|org.kuali.student.r1.common.assembly.data.Data$StringValue/223926985|AL|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|courseTitle|#{opts[:course_title]}|creditOptions|crossListings|descr|plain|#{opts[:course_description]}|expenditure|affiliatedOrgs|fees|formats|gradingOptions|id|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|%%_#{opts[:instructor_id_var_name]}%%|personId|#{opts[:instructor]}|_runtimeData|id-translation|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|meta|createId|#{opts[:propose_person]}|createTime|org.kuali.student.r1.common.assembly.data.Data$DateValue/2782133523|java.util.Date/3385151746|updateId|updateTime|versionInd|#{version_indicator+=1}|pilotCourse|org.kuali.student.r1.common.assembly.data.Data$BooleanValue/2980665104|java.lang.Boolean/476441737|revenues|specialTopicsCourse|state|draft|stateKey|subjectArea|#{opts[:subject_area]}|termsOffered|transcriptTitle|#{opts[:course_short_title]}|type|kuali.lu.type.CreditCourse|typeKey|unitsContentOwner|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|%%_#{opts[:admin_dep_var_name]}%%|#{admin_org}|variations|version|currentVersionStart|sequenceNumber|org.kuali.student.r1.common.assembly.data.Data$LongValue/3940989517|java.lang.Long/4227064769|versionIndId|%%_#{opts[:version_ind_id_name]}%%|dirty|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|1|name|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|formatted|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators"
    contents2 = "|1|2|3|4|1|5|5|6|7|0|34|8|9|10|5|6|7|0|1|11|12|0|13|14|-1|8|9|8|15|13|16|8|17|13|18|8|19|10|5|6|7|0|0|-1|-15|8|20|13|21|8|22|10|5|6|7|0|0|-1|-21|8|23|10|5|6|7|0|0|-1|-25|8|24|10|5|6|7|0|1|8|25|13|26|-1|-29|8|27|10|5|6|7|0|1|8|28|10|5|6|7|0|0|-37|-39|-1|-35|8|29|10|5|6|7|0|0|-1|-43|8|30|10|5|6|7|0|0|-1|-47|8|31|10|5|6|7|0|0|-1|-51|8|32|13|33|8|34|10|5|6|7|0|1|11|-8|10|5|6|7|0|3|8|32|13|35|8|36|13|37|8|38|10|5|6|7|0|1|8|36|10|5|6|7|0|1|8|39|13|40|-71|-73|-63|-69|-59|-61|-1|-57|8|41|10|5|6|7|0|0|-1|-79|8|42|13|43|8|44|10|5|6|7|0|5|8|45|13|46|8|47|48|49|Tuphsnx|8|50|13|46|8|51|48|49|Tuphsnx|8|52|13|53|-1|-85|8|54|55|56|0|8|57|10|5|6|7|0|0|-1|-104|8|58|55|-103|8|59|13|60|8|61|13|60|8|62|13|63|8|64|10|5|6|7|0|0|-1|-116|8|65|13|66|8|67|13|68|8|69|13|68|8|70|10|5|6|7|0|2|11|-8|13|71|8|38|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|39|13|72|-134|-136|-128|-132|-1|8|70|8|73|10|5|6|7|0|2|11|-8|13|74|8|38|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|39|13|75|-151|-153|-145|-149|-1|8|73|8|76|10|5|6|7|0|0|-1|-160|8|77|10|5|6|7|0|3|8|78|48|49|Tuphsnx|8|79|80|81|B|8|82|13|83|-1|-164|8|38|10|5|6|7|0|2|8|62|10|5|6|7|0|1|8|39|13|63|-178|-180|8|84|10|5|6|7|0|3|8|9|55|56|1|8|70|55|-192|8|73|55|-192|-178|-186|-1|-176|8|85|10|5|6|7|0|14|8|86|13|87|8|32|13|88|8|44|10|5|6|7|0|5|8|45|13|46|8|47|48|49|TuphstT|8|50|13|46|8|51|48|49|Tuphs6s|8|52|13|89|-199|-205|8|90|13|21|8|91|10|5|6|7|0|1|11|-8|13|33|-199|-223|8|92|13|93|8|94|10|5|6|7|0|0|-199|-231|8|95|10|5|6|7|0|0|-199|-235|8|96|10|5|6|7|0|2|8|97|13|98|8|25|13|98|-199|-239|8|59|13|99|8|61|13|99|8|67|13|100|8|69|13|100|8|101|13|102|-1|-197|8|103|10|5|6|7|0|1|8|104|10|5|6|7|0|0|-259|-261|-1|-257|0|0|"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "#{contents1}#{contents2}"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )


    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lu.queryParam.luOptionalLuTypeStartsWith|java.lang.String/2004016611|kuali.lu.type.activity.|lu.search.all.lu.Types|lu.resultColumn.luTypeName|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      {
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.atptype.duration|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      {
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    
    
    #
    # Course Logistics    
    # Term: Any
    # Duration Type: Semester
    # Duration Count: 2
    # Assessment Scale: Letter
    # Standard Final Exam
    # Outcome: 10 credits
    # Course Format
    # => Activity Type: Lab, Contact Hours: 5, Frequency: weekly
    # => Duration Type: Weekly
    # => Duration: 13
    # => Anticipated class size: 100

    @request.add_thinktime(30)

    # Save & Continue
    contents1 = "7|0|131|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.r1.common.assembly.data.Data/1485826496|org.kuali.student.r1.common.assembly.data.Data|java.util.LinkedHashMap/3008245022|org.kuali.student.r1.common.assembly.data.Data$StringKey/642388540|campusLocations|org.kuali.student.r1.common.assembly.data.Data$DataValue/690845158|org.kuali.student.r1.common.assembly.data.Data$IntegerKey/2963918776|java.lang.Integer/3438268394|org.kuali.student.r1.common.assembly.data.Data$StringValue/223926985|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|courseTitle|#{opts[:course_title]}|creditOptions|dirty|typeKey|org.kuali.student.r1.common.assembly.data.Data$BooleanValue/2980665104|java.lang.Boolean/476441737|created|kuali.result.values.group.type.fixed|resultValueRange|minValue|10|crossListings|descr|plain|#{opts[:course_description]}|expenditure|affiliatedOrgs|fees|formats|activities|defaultEnrollmentEstimate|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitTypeKey|kuali.atp.duration.week|duration|atpDurationTypeKey|timeQuantity|kuali.atp.duration.Week|org.kuali.student.r1.common.assembly.data.Data$IntegerValue/2595436661|gradingOptions|kuali.resultComponent.grade.letter|id|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|%%_#{opts[:instructor_id_var_name]}%%|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|meta|createId|#{opts[:propose_person]}|createTime|org.kuali.student.r1.common.assembly.data.Data$DateValue/2782133523|java.sql.Timestamp/3040052672|updateId|updateTime|java.util.Date/3385151746|versionInd|#{version_indicator+=1}|pilotCourse|revenues|specialTopicsCourse|state|draft|stateKey|subjectArea|#{opts[:subject_area]}|termsOffered|kuali.atp.season.Any|transcriptTitle|#{opts[:course_short_title]}|type|kuali.lu.type.CreditCourse|unitsContentOwner|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|%%_#{opts[:admin_dep_var_name]}%%|#{admin_org}|variations|version|currentVersionStart|sequenceNumber|org.kuali.student.r1.common.assembly.data.Data$LongValue/3940989517|java.lang.Long/4227064769|versionIndId|%%_#{opts[:version_ind_id_name]}%%|finalExamStatus|audit|passFail|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|2|name|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|formatted|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators|kuali.atp.duration.Semester|STD"
    contents2 = "|1|2|3|4|1|5|5|6|7|0|38|8|9|10|5|6|7|0|2|11|12|0|13|14|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|17|-12|-14|-5|-10|-1|-3|8|18|13|19|8|20|13|21|8|22|10|5|6|7|0|0|-1|-24|8|23|13|24|8|25|10|5|6|7|0|1|11|-8|10|5|6|7|0|3|8|15|10|5|6|7|0|3|8|26|10|5|6|7|0|1|8|27|28|29|1|-40|-42|8|30|28|-48|-38|10|5|6|7|0|1|-42|10|5|6|7|0|1|-49|28|-48|-52|-42|-40|-38|-36|-38|-46|13|31|8|32|10|5|6|7|0|2|-38|10|5|6|7|0|1|-42|10|5|6|7|0|1|8|33|28|-48|-64|-42|-61|-38|8|33|13|34|-36|-59|-32|-34|-1|-30|8|35|10|5|6|7|0|0|-1|-73|8|36|10|5|6|7|0|1|8|37|13|38|-1|-77|8|39|10|5|6|7|0|1|8|40|10|5|6|7|0|0|-85|-87|-1|-83|8|41|10|5|6|7|0|0|-1|-91|8|42|10|5|6|7|0|1|11|-8|10|5|6|7|0|2|8|43|10|5|6|7|0|1|11|-8|10|5|6|7|0|5|-38|10|5|6|7|0|3|-42|10|5|6|7|0|2|8|27|28|-48|8|44|28|-48|-112|-42|8|30|28|-48|-38|10|5|6|7|0|1|-42|10|5|6|7|0|1|-121|28|-48|-124|-42|-112|-38|-109|-38|-117|13|45|8|46|10|5|6|7|0|3|8|47|13|48|-38|10|5|6|7|0|1|-42|10|5|6|7|0|2|-135|28|-48|8|49|28|-48|-138|-42|-133|-38|-144|13|50|-109|-131|8|51|10|5|6|7|0|3|-38|10|5|6|7|0|1|-42|10|5|6|7|0|2|8|52|28|-48|8|53|28|-48|-152|-42|-149|-38|-157|13|54|-159|55|12|13|-109|-147|-119|55|12|100|-105|-107|-101|-103|8|15|10|5|6|7|0|2|8|30|28|-48|-38|10|5|6|7|0|1|-42|10|5|6|7|0|1|-170|28|-48|-173|-42|-168|-38|-101|-166|-97|-99|-1|-95|8|56|10|5|6|7|0|1|11|-8|13|57|-1|8|56|8|58|13|59|8|60|10|5|6|7|0|1|11|-8|10|5|6|7|0|3|8|58|13|61|8|62|13|63|8|15|10|5|6|7|0|1|8|62|10|5|6|7|0|1|8|16|13|64|-202|-204|-194|-200|-190|-192|-1|-188|8|65|10|5|6|7|0|0|-1|-210|8|66|13|67|8|68|10|5|6|7|0|5|8|69|13|70|8|71|72|73|Tuphsnx|265000000|8|74|13|70|8|75|72|76|Tupia8B|8|77|13|78|-1|-216|8|79|28|29|0|8|80|10|5|6|7|0|0|-1|-235|8|81|28|-234|8|82|13|83|8|84|13|83|8|85|13|86|8|87|10|5|6|7|0|1|11|-8|13|88|-1|8|87|8|89|13|90|8|91|13|92|8|27|13|92|8|93|10|5|6|7|0|2|11|-8|13|94|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|95|-268|-270|-262|-266|-1|-260|8|96|10|5|6|7|0|2|11|-8|13|97|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|98|-284|-286|-278|-282|-1|-276|8|99|10|5|6|7|0|0|-1|-292|8|100|10|5|6|7|0|3|8|101|72|73|Tuphsnx|265000000|8|102|103|104|B|8|105|13|106|-1|-296|8|15|10|5|6|7|0|2|8|85|10|5|6|7|0|1|8|16|13|86|-310|-312|-42|10|5|6|7|0|5|8|87|28|-48|8|56|28|-48|8|107|28|-48|8|108|28|-48|8|109|28|-48|-310|-42|-1|-308|8|110|10|5|6|7|0|14|8|111|13|112|8|58|13|113|8|68|10|5|6|7|0|5|8|69|13|70|8|71|72|73|TuphstT|619000000|8|74|13|70|8|75|72|76|TupibNg|8|77|13|114|-333|-339|8|115|13|24|8|116|10|5|6|7|0|1|11|-8|13|59|-333|-357|8|117|13|118|8|119|10|5|6|7|0|0|-333|-365|8|120|10|5|6|7|0|0|-333|-369|8|121|10|5|6|7|0|2|8|122|13|123|8|37|13|123|-333|-373|8|82|13|124|8|84|13|124|8|91|13|125|8|27|13|125|8|126|13|127|-1|-331|8|128|10|5|6|7|0|1|8|129|10|5|6|7|0|0|-393|-395|-1|-391|8|51|10|5|6|7|0|3|-38|10|5|6|7|0|1|-42|10|5|6|7|0|2|8|52|28|-48|8|53|28|-48|-404|-42|-401|-38|-409|13|130|-411|55|12|2|-1|-399|-325|13|131|-327|28|-234|-329|28|-234|0|0|"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
     {
       'method' => 'POST',
       'content_type' => 'text/x-gwt-rpc; charset=utf-8',
       'contents' => "#{contents1}#{contents2}"
     },
     {
       'subst' => 'true',
       :dyn_variables => [
         {"name" => opts[:enroll_est_var_name], "re" => opts[:enroll_est_var_regexp]},
         {"name" => opts[:lab_var_name], "re" => opts[:lab_var_regexp]},
         {"name" => opts[:atp_duration_week_var_name], "re" => opts[:atp_duration_week_var_regexp]}
        ],
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
     }
    )

    #@request.add("DEBUG/enroll_est_var_name/%%_#{opts[:enroll_est_var_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    #@request.add("DEBUG/lab_var_name/%%_#{opts[:lab_var_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    #@request.add("DEBUG/atp_duration_week_var_name/%%_#{opts[:atp_duration_week_var_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})

    @request.add_thinktime(2)
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    
    #
    # Learning Objectives
    #

    @request.add_thinktime(5)

    # Category
    for i in 1..opts[:lo_category].length
      itr = i-1
      if(i == opts[:lo_category].length)
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lo.queryParam.loOptionalCategoryName|java.lang.String/2004016611|#{opts[:lo_category][0..itr]}|lo.search.loCategories|1|2|3|4|1|5|5|0|0|6|0|7|1|8|0|9|7|1|10|11|12|0|0|0|"
          },
          {
            :dyn_variables => [
              {"name" => opts[:lo_category_id_var_name], "re" => opts[:lo_category_id_var_regexp]}
            ],
            :custom_headers => {
              'X-GWT-Permutation' => "HostedMode"
            }
          }
        )

        #@request.add("DEBUG/lo_category_id_var_name/%%_#{opts[:lo_category_id_var_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})

      else
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|lo.queryParam.loOptionalCategoryName|java.lang.String/2004016611|#{opts[:lo_category][0..itr]}|lo.search.loCategories|1|2|3|4|1|5|5|0|0|6|0|7|1|8|0|9|7|1|10|11|12|0|0|0|"
          },      
          {
            :custom_headers => {
              'X-GWT-Permutation' => "HostedMode"}
          }                             
        )
      end   
    end


    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/LoCategoryRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|93BB2199AB36894F63B79E088FC7351B|org.kuali.student.lum.common.client.lo.rpc.LoCategoryRpcService|getData|java.lang.String/2004016611|%%_#{opts[:lo_category_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/LoCategoryRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|93BB2199AB36894F63B79E088FC7351B|org.kuali.student.lum.common.client.lo.rpc.LoCategoryRpcService|getLoCategoryType|java.lang.String/2004016611|loCategoryType.subject|1|2|3|4|1|5|6|"
      },
      {
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    @request.add_thinktime(25)

    # Save & Continue
    contents1 = "7|0|158|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.r1.common.assembly.data.Data/1485826496|org.kuali.student.r1.common.assembly.data.Data|java.util.LinkedHashMap/3008245022|org.kuali.student.r1.common.assembly.data.Data$StringKey/642388540|finalExamStatus|org.kuali.student.r1.common.assembly.data.Data$StringValue/223926985|STD|audit|org.kuali.student.r1.common.assembly.data.Data$BooleanValue/2980665104|java.lang.Boolean/476441737|passFail|campusLocations|org.kuali.student.r1.common.assembly.data.Data$DataValue/690845158|org.kuali.student.r1.common.assembly.data.Data$IntegerKey/2963918776|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loInfo|id|descr|formatted|#{opts[:lo_cat_text]}|plain|name|SINGLE USE LO|sequence|0|meta|loCategoryInfoList|%%_#{opts[:lo_category_id_var_name]}%%|#{opts[:lo_category]}|loRepositoryKey|kuali.loRepository.key.singleUse|effectiveDate|org.kuali.student.r1.common.assembly.data.Data$DateValue/2782133523|expirationDate|stateKey|active|typeKey|loCategoryType.subject|createId|admin|createTime|java.sql.Timestamp/3040052672|updateId|updateTime|versionInd|courseTitle|#{opts[:course_title]}|creditOptions|key|kuali.creditType.credit.degree.10.0|resultValueKeys|resultValueRange|minValue|10|type|kuali.result.values.group.type.fixed|Fixed|crossListings|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.r1.common.assembly.data.Data$IntegerValue/2595436661|Semester|expenditure|affiliatedOrgs|fees|formats|activities|contactHours|unitQuantity|5|unitTypeKey|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|#{opts[:propose_person]}|java.util.Date/3385151746|draft|state|kuali.lu.type.activity.Lab|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|%%_#{opts[:instructor_id_var_name]}%%|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|2|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|%%_#{opts[:admin_dep_var_name]}%%|#{admin_org}|variations|version|currentVersionStart|sequenceNumber|org.kuali.student.r1.common.assembly.data.Data$LongValue/3940989517|java.lang.Long/4227064769|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Standard final Exam|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|3|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators"
    contents2 = "|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|8|12|13|14|0|8|15|13|-7|8|16|17|5|6|7|0|2|18|19|0|10|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|23|-19|-21|-12|-17|-1|-10|8|24|10|25|8|26|10|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|29|17|5|6|7|0|5|8|30|10|0|8|31|17|5|6|7|0|2|8|32|10|33|8|34|10|33|-41|-45|8|35|10|36|8|37|10|38|8|39|17|0|-37|-39|8|40|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|30|10|41|8|35|10|42|8|31|17|5|6|7|0|2|8|32|10|0|8|34|10|0|-65|-71|8|43|10|44|8|45|46|0|8|47|46|0|8|48|10|49|8|50|10|51|8|39|17|5|6|7|0|5|8|52|10|53|8|54|46|55|SzgEBxI|0|8|56|10|53|8|57|46|55|SzgEBxI|0|8|58|10|38|-65|-89|-61|-63|-37|-59|-33|-35|-1|8|28|8|59|10|60|8|61|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|62|10|63|8|64|17|5|6|7|0|0|-114|-118|8|65|17|5|6|7|0|1|8|66|10|67|-114|-122|8|68|10|69|8|50|10|69|8|21|17|5|6|7|0|1|8|50|17|5|6|7|0|1|8|22|10|70|-134|-136|-114|-132|-110|-112|-1|-108|8|71|17|5|6|7|0|0|-1|-142|8|31|17|5|6|7|0|1|8|34|10|72|-1|-146|8|73|17|5|6|7|0|3|8|74|10|75|8|76|77|19|2|8|21|17|5|6|7|0|1|8|74|17|5|6|7|0|1|8|22|10|78|-163|-165|-154|-161|-1|-152|8|79|17|5|6|7|0|1|8|80|17|5|6|7|0|0|-173|-175|-1|-171|8|81|17|5|6|7|0|0|-1|-179|8|82|17|5|6|7|0|1|18|-15|17|5|6|7|0|8|8|83|17|5|6|7|0|1|18|-15|17|5|6|7|0|12|8|84|17|5|6|7|0|3|8|85|10|86|8|87|10|88|8|21|17|5|6|7|0|1|8|87|17|5|6|7|0|1|8|22|10|89|-209|-211|-201|-207|-197|-199|8|90|77|19|100|8|73|17|5|6|7|0|3|8|74|10|91|8|76|77|19|13|8|21|17|5|6|7|0|1|8|74|17|5|6|7|0|1|8|22|10|92|-231|-233|-222|-229|-197|-220|8|30|10|93|8|39|17|5|6|7|0|5|8|52|10|94|8|54|46|95|TupiwnQ|8|56|10|94|8|57|46|95|TupiwnQ|8|58|10|38|-197|-241|8|35|10|96|8|97|10|96|8|48|10|96|8|68|10|98|8|50|10|98|8|99|17|5|6|7|0|0|-197|-267|8|21|17|5|6|7|0|1|8|50|17|5|6|7|0|1|8|22|10|100|-273|-275|-197|-271|-193|-195|-189|-191|8|30|10|101|8|39|17|5|6|7|0|5|8|52|10|94|8|54|46|95|Tupiwmj|8|56|10|94|8|57|46|95|Tupiwmj|8|58|10|38|-189|-283|8|97|10|96|8|48|10|96|8|102|17|5|6|7|0|0|-189|-303|8|68|10|103|8|50|10|103|-185|-187|-1|-183|8|104|17|5|6|7|0|2|18|-15|10|105|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|106|-319|-321|-313|-317|-1|-311|8|30|10|107|8|108|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|30|10|109|8|110|10|111|8|21|17|5|6|7|0|1|8|110|17|5|6|7|0|1|8|22|10|112|-343|-345|-335|-341|-331|-333|-1|-329|8|113|17|5|6|7|0|0|-1|-351|8|114|10|115|8|39|17|5|6|7|0|5|8|52|10|94|8|54|46|55|Tuphsnx|265000000|8|56|10|94|8|57|46|95|Tupiwlk|8|58|10|116|-1|-357|8|117|13|-7|8|118|17|5|6|7|0|0|-1|-375|8|119|13|-7|8|97|10|96|8|48|10|96|8|120|10|121|8|102|17|5|6|7|0|2|18|-15|10|122|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|123|-395|-397|-389|-393|-1|-387|8|124|10|125|8|68|10|126|8|50|10|126|8|99|17|5|6|7|0|2|18|-15|10|127|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|128|-417|-419|-411|-415|-1|-409|8|129|17|5|6|7|0|2|18|-15|10|130|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|131|-433|-435|-427|-431|-1|-425|8|132|17|5|6|7|0|0|-1|-441|8|133|17|5|6|7|0|3|8|134|46|55|Tuphsnx|265000000|8|135|136|137|B|8|138|10|139|-1|-445|8|21|17|5|6|7|0|2|8|120|17|5|6|7|0|1|8|22|10|121|-459|-461|8|9|17|5|6|7|0|1|8|22|10|140|-459|-467|-1|-457|8|141|17|5|6|7|0|14|8|142|10|143|8|30|10|144|8|39|17|5|6|7|0|5|8|52|10|94|8|54|46|55|TuphstT|619000000|8|56|10|94|8|57|46|95|Tupiw6r|8|58|10|145|-475|-481|8|35|10|60|8|146|17|5|6|7|0|1|18|-15|10|107|-475|-499|8|147|10|148|8|149|17|5|6|7|0|0|-475|-507|8|150|17|5|6|7|0|0|-475|-511|8|151|17|5|6|7|0|2|8|32|10|152|8|34|10|152|-475|-515|8|97|10|153|8|48|10|153|8|68|10|154|8|50|10|154|8|155|10|156|-1|-473|8|157|17|5|6|7|0|1|8|158|17|5|6|7|0|0|-535|-537|-1|-533|0|0|"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "#{contents1}#{contents2}"
      },
      {
        'subst' => 'true',
        :dyn_variables => [
          {"name" => opts[:lo_category_var_name], "re" => opts[:lo_category_var_regexp]}
        ],
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )


    #@request.add("DEBUG/lo_category_var_name/%%_#{opts[:lo_category_var_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})

    @request.add_thinktime(2)

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/LoCategoryRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|93BB2199AB36894F63B79E088FC7351B|org.kuali.student.lum.common.client.lo.rpc.LoCategoryRpcService|getLoCategoryTypes|1|2|3|4|0|"
      },      
      {
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|ABC7A51BAB09732A2470B566E5316DE9|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      },
      {
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3F980EEE5504E0742F014B8BB23B3D45|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:clu_ref_dyn_var_name]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    
    #
    # Course Requisites
    # Save without editing anything

    @request.add_thinktime(5)

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3F980EEE5504E0742F014B8BB23B3D45|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|storeCourseStatements|java.lang.String/2004016611|java.util.Map|%%_#{opts[:clu_ref_dyn_var_name]}%%|draft|java.util.HashMap/1797211028|java.util.LinkedHashMap/3008245022|1|2|3|4|4|5|5|6|6|7|8|9|0|10|0|0|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
 
    
    #
    # Active Dates
    # Start = Fall Sem 2008
    #

    @request.add_thinktime(10)
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|20084|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|0|6|2|7|0|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|7|0|17|6|1|9|18|19|20|0|0|"
      },
      {
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    # Save & Continue
    contents1 = "7|0|165|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.r1.common.assembly.data.Data/1485826496|org.kuali.student.r1.common.assembly.data.Data|java.util.LinkedHashMap/3008245022|org.kuali.student.r1.common.assembly.data.Data$StringKey/642388540|finalExamStatus|org.kuali.student.r1.common.assembly.data.Data$StringValue/223926985|STD|audit|org.kuali.student.r1.common.assembly.data.Data$BooleanValue/2980665104|java.lang.Boolean/476441737|passFail|campusLocations|org.kuali.student.r1.common.assembly.data.Data$DataValue/690845158|org.kuali.student.r1.common.assembly.data.Data$IntegerKey/2963918776|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|descr|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepositoryKey|kuali.loRepository.key.singleUse|meta|createId|admin|createTime|org.kuali.student.r1.common.assembly.data.Data$DateValue/2782133523|java.sql.Timestamp/3040052672|updateId|updateTime|versionInd|0|metaInfo|name|#{opts[:lo_category]}|state|active|stateKey|type|loCategoryType.subject|typeKey|loDisplayInfoList|loInfo|sequence|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|#{opts[:propose_person]}|java.util.Date/3385151746|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|key|kuali.creditType.credit.degree.10.0|resultValueKeys|resultValueRange|minValue|10|kuali.result.values.group.type.fixed|Fixed|crossListings|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.r1.common.assembly.data.Data$IntegerValue/2595436661|Semester|expenditure|affiliatedOrgs|fees|formats|activities|contactHours|unitQuantity|5|unitTypeKey|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|1|kuali.lu.type.activity.Lab|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|%%_#{opts[:instructor_id_var_name]}%%|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|3|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|%%_#{opts[:admin_dep_var_name]}%%|#{admin_org}|variations|version|currentVersionStart|sequenceNumber|org.kuali.student.r1.common.assembly.data.Data$LongValue/3940989517|java.lang.Long/4227064769|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Standard final Exam|dirty|startTerm|endTerm|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|4|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators|20084"
    contents2 = "|1|2|3|4|1|5|5|6|7|0|40|8|9|10|11|8|12|13|14|0|8|15|13|-7|8|16|17|5|6|7|0|2|18|19|0|10|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|23|-19|-21|-12|-17|-1|-10|8|24|10|25|8|26|10|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|10|8|30|17|5|6|7|0|0|-45|-47|8|31|10|32|8|33|10|34|8|35|17|5|6|7|0|5|8|36|10|37|8|38|39|40|SzgEBxI|0|8|41|10|37|8|42|39|40|SzgEBxI|0|8|43|10|44|-45|-55|8|45|17|5|6|7|0|5|8|36|10|37|8|38|39|-63|8|41|10|37|8|42|39|-68|8|43|10|44|-45|-71|8|46|10|47|8|48|10|49|8|50|10|49|8|51|10|52|8|53|10|52|-41|-43|-37|-39|8|54|17|5|6|7|0|0|-37|-95|8|55|17|5|6|7|0|10|8|56|10|44|8|30|17|5|6|7|0|2|8|57|10|58|8|59|10|58|-101|-105|8|31|10|60|8|33|10|34|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|62|TupjA9P|8|41|10|61|8|42|39|62|TupjA9P|8|43|10|44|-101|-117|8|46|10|63|8|48|10|64|8|50|10|64|8|51|10|65|8|53|10|65|-37|-99|-33|-35|-1|-31|8|66|10|67|8|68|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|69|10|70|8|71|17|5|6|7|0|0|-151|-155|8|72|17|5|6|7|0|1|8|73|10|74|-151|-159|8|51|10|75|8|53|10|75|8|21|17|5|6|7|0|1|8|53|17|5|6|7|0|1|8|22|10|76|-171|-173|-151|-169|-147|-149|-1|-145|8|77|17|5|6|7|0|0|-1|-179|8|30|17|5|6|7|0|1|8|59|10|78|-1|-183|8|79|17|5|6|7|0|3|8|80|10|81|8|82|83|19|2|8|21|17|5|6|7|0|1|8|80|17|5|6|7|0|1|8|22|10|84|-200|-202|-191|-198|-1|-189|8|85|17|5|6|7|0|1|8|86|17|5|6|7|0|0|-210|-212|-1|-208|8|87|17|5|6|7|0|0|-1|-216|8|88|17|5|6|7|0|1|18|-15|17|5|6|7|0|8|8|89|17|5|6|7|0|1|18|-15|17|5|6|7|0|12|8|90|17|5|6|7|0|3|8|91|10|92|8|93|10|94|8|21|17|5|6|7|0|1|8|93|17|5|6|7|0|1|8|22|10|95|-246|-248|-238|-244|-234|-236|8|96|83|19|100|8|79|17|5|6|7|0|3|8|80|10|97|8|82|83|19|13|8|21|17|5|6|7|0|1|8|80|17|5|6|7|0|1|8|22|10|98|-268|-270|-259|-266|-234|-257|8|31|10|99|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupiwnQ|760000000|8|41|10|61|8|42|39|62|TupjA8M|8|43|10|100|-234|-278|8|46|10|64|8|48|10|64|8|50|10|64|8|51|10|101|8|53|10|101|8|102|17|5|6|7|0|0|-234|-304|8|21|17|5|6|7|0|1|8|53|17|5|6|7|0|1|8|22|10|103|-310|-312|-234|-308|-230|-232|-226|-228|8|31|10|104|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|Tupiwmj|715000000|8|41|10|61|8|42|39|62|TupjA7z|8|43|10|100|-226|-320|8|48|10|64|8|50|10|64|8|105|17|5|6|7|0|0|-226|-340|8|51|10|106|8|53|10|106|-222|-224|-1|-220|8|107|17|5|6|7|0|2|18|-15|10|108|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|109|-356|-358|-350|-354|-1|-348|8|31|10|110|8|111|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|31|10|112|8|113|10|114|8|21|17|5|6|7|0|1|8|113|17|5|6|7|0|1|8|22|10|115|-380|-382|-372|-378|-368|-370|-1|-366|8|116|17|5|6|7|0|0|-1|-388|8|117|10|118|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|Tuphsnx|265000000|8|41|10|61|8|42|39|62|TupjA7N|8|43|10|119|-1|-394|8|120|13|-7|8|121|17|5|6|7|0|0|-1|-412|8|122|13|-7|8|48|10|64|8|50|10|64|8|123|10|124|8|105|17|5|6|7|0|2|18|-15|10|125|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|126|-432|-434|-426|-430|-1|-424|8|127|10|128|8|51|10|129|8|53|10|129|8|102|17|5|6|7|0|2|18|-15|10|130|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|131|-454|-456|-448|-452|-1|-446|8|132|17|5|6|7|0|2|18|-15|10|133|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|134|-470|-472|-464|-468|-1|-462|8|135|17|5|6|7|0|0|-1|-478|8|136|17|5|6|7|0|3|8|137|39|40|Tuphsnx|265000000|8|138|139|140|B|8|141|10|142|-1|-482|8|21|17|5|6|7|0|3|8|123|17|5|6|7|0|1|8|22|10|124|-496|-498|8|9|17|5|6|7|0|1|8|22|10|143|-496|-504|8|144|17|5|6|7|0|2|8|145|13|14|1|8|146|13|-516|-496|-510|-1|-494|8|147|17|5|6|7|0|14|8|148|10|149|8|31|10|150|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TuphstT|619000000|8|41|10|61|8|42|39|62|TupjBRP|8|43|10|151|-521|-527|8|46|10|67|8|152|17|5|6|7|0|1|18|-15|10|110|-521|-545|8|153|10|154|8|155|17|5|6|7|0|0|-521|-553|8|156|17|5|6|7|0|0|-521|-557|8|157|17|5|6|7|0|2|8|57|10|158|8|59|10|158|-521|-561|8|48|10|159|8|50|10|159|8|51|10|160|8|53|10|160|8|161|10|162|-1|-519|8|163|17|5|6|7|0|1|8|164|17|5|6|7|0|0|-581|-583|-1|-579|-514|10|165|-517|10|0|0|0|"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "#{contents1}#{contents2}"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    
    
    #
    # Financials
    # $100 lab fee
    # Admin org 100% rev and exp
    #

    @request.add_thinktime(5)

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|enumeration.queryParam.enumerationType|java.lang.String/2004016611|kuali.lu.fee.feeType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|0|6|1|7|0|8|6|1|9|10|11|12|0|0|"
      },
      {
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    # Revenue - Admin Org
    for i in 1..admin_org.length
      itr = i-1
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|org.queryParam.orgOptionalLongName|java.lang.String/2004016611|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|kuali.org.Department|kuali.org.College|org.search.generic|org.resultColumn.orgOptionalLongName|1|2|3|4|1|5|5|0|0|6|0|7|2|8|0|9|7|1|10|11|8|0|12|7|2|10|13|10|14|15|16|0|0|"
      },
      {
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
      )    
    end

    @request.add_thinktime(5)

    # Expense - Admin Org
    for i in 1..admin_org.length
      itr = i-1
      if(i == admin_org.length)
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "7|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|org.queryParam.orgOptionalLongName|java.lang.String/2004016611|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|kuali.org.Department|kuali.org.College|org.search.generic|org.resultColumn.orgOptionalLongName|1|2|3|4|1|5|5|0|0|6|0|7|2|8|0|9|7|1|10|11|8|0|12|7|2|10|13|10|14|15|16|0|0|"
          },
          {
            :dyn_variables => [
                {"name" => opts[:admin_dep_var_name], "re" => opts[:admin_dep_var_regexp]}
              ],
            :custom_headers => {
              'X-GWT-Permutation' => "HostedMode"}
          } 
        )
      else
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "7|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|org.queryParam.orgOptionalLongName|java.lang.String/2004016611|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|kuali.org.Department|kuali.org.College|org.search.generic|org.resultColumn.orgOptionalLongName|1|2|3|4|1|5|5|0|0|6|0|7|2|8|0|9|7|1|10|11|8|0|12|7|2|10|13|10|14|15|16|0|0|"
          },
          {
            :custom_headers => {
              'X-GWT-Permutation' => "HostedMode"}
          }    
        )
      end    
    end

    #@request.add("DEBUG/admin_dep_var_name/%%_#{opts[:admin_dep_var_name]}%%", {}, {'subst' => 'true'})

    @request.add_thinktime(20)

    # Save & Continue
    contents1 = "7|0|175|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.r1.common.assembly.data.Data/1485826496|org.kuali.student.r1.common.assembly.data.Data|java.util.LinkedHashMap/3008245022|org.kuali.student.r1.common.assembly.data.Data$StringKey/642388540|finalExamStatus|org.kuali.student.r1.common.assembly.data.Data$StringValue/223926985|STD|audit|org.kuali.student.r1.common.assembly.data.Data$BooleanValue/2980665104|java.lang.Boolean/476441737|passFail|campusLocations|org.kuali.student.r1.common.assembly.data.Data$DataValue/690845158|org.kuali.student.r1.common.assembly.data.Data$IntegerKey/2963918776|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|descr|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepositoryKey|kuali.loRepository.key.singleUse|meta|createId|admin|createTime|org.kuali.student.r1.common.assembly.data.Data$DateValue/2782133523|java.sql.Timestamp/3040052672|updateId|updateTime|versionInd|0|metaInfo|name|#{opts[:lo_category]}|state|active|stateKey|type|loCategoryType.subject|typeKey|loDisplayInfoList|loInfo|sequence|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|#{opts[:propose_person]}|java.util.Date/3385151746|1|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|key|kuali.creditType.credit.degree.10.0|resultValueKeys|resultValueRange|minValue|10|kuali.result.values.group.type.fixed|Fixed|crossListings|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.r1.common.assembly.data.Data$IntegerValue/2595436661|Semester|effectiveDate|expenditure|affiliatedOrgs|dirty|orgId|percentage|created|%%_#{opts[:admin_dep_var_name]}%%|org.kuali.student.r1.common.assembly.data.Data$LongValue/3940989517|java.lang.Long/4227064769|fees|feeType|rateType|kuali.enum.type.feeTypes.labFee|fixedRateFee|feeAmounts|currencyQuantity|formats|activities|contactHours|unitQuantity|5|unitTypeKey|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|2|kuali.lu.type.activity.Lab|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|%%_#{opts[:instructor_id_var_name]}%%|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|4|pilotCourse|revenues|specialTopicsCourse|startTerm|20084|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|#{admin_org}|variations|version|currentVersionStart|sequenceNumber|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Fall 2008|Standard final Exam|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators"
    contents2 = "|1|2|3|4|1|5|5|6|7|0|40|8|9|10|11|8|12|13|14|0|8|15|13|-7|8|16|17|5|6|7|0|2|18|19|0|10|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|23|-19|-21|-12|-17|-1|-10|8|24|10|25|8|26|10|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|10|8|30|17|5|6|7|0|0|-45|-47|8|31|10|32|8|33|10|34|8|35|17|5|6|7|0|5|8|36|10|37|8|38|39|40|SzgEBxI|0|8|41|10|37|8|42|39|40|SzgEBxI|0|8|43|10|44|-45|-55|8|45|17|5|6|7|0|5|8|36|10|37|8|38|39|-63|8|41|10|37|8|42|39|-68|8|43|10|44|-45|-71|8|46|10|47|8|48|10|49|8|50|10|49|8|51|10|52|8|53|10|52|-41|-43|-37|-39|8|54|17|5|6|7|0|0|-37|-95|8|55|17|5|6|7|0|10|8|56|10|44|8|30|17|5|6|7|0|2|8|57|10|58|8|59|10|58|-101|-105|8|31|10|60|8|33|10|34|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupjA9P|703000000|8|41|10|61|8|42|39|62|TupjYDp|8|43|10|63|-101|-117|8|46|10|64|8|48|10|65|8|50|10|65|8|51|10|66|8|53|10|66|-37|-99|-33|-35|-1|-31|8|67|10|68|8|69|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|70|10|71|8|72|17|5|6|7|0|0|-151|-155|8|73|17|5|6|7|0|1|8|74|10|75|-151|-159|8|51|10|76|8|53|10|76|8|21|17|5|6|7|0|1|8|53|17|5|6|7|0|1|8|22|10|77|-171|-173|-151|-169|-147|-149|-1|-145|8|78|17|5|6|7|0|0|-1|-179|8|30|17|5|6|7|0|1|8|59|10|79|-1|-183|8|80|17|5|6|7|0|3|8|81|10|82|8|83|84|19|2|8|21|17|5|6|7|0|1|8|81|17|5|6|7|0|1|8|22|10|85|-200|-202|-191|-198|-1|-189|8|86|39|40|RySg3IA|0|8|87|17|5|6|7|0|1|8|88|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|21|17|5|6|7|0|3|8|89|17|5|6|7|0|2|8|90|13|14|1|8|91|13|-233|-225|-227|8|92|13|-233|-223|17|5|6|7|0|1|-227|17|5|6|7|0|1|-236|13|-233|-239|-227|-225|-223|-221|-223|-231|10|93|-234|94|95|Bk|-217|-219|-213|-215|-1|-211|8|96|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|-223|17|5|6|7|0|3|-227|17|5|6|7|0|2|8|97|13|-233|8|98|13|-233|-257|-227|8|92|13|-233|-223|17|5|6|7|0|1|-227|17|5|6|7|0|1|-266|13|-233|-269|-227|-257|-223|-254|-223|-262|10|99|-264|10|100|8|101|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|102|84|19|100|-223|17|5|6|7|0|1|-227|17|5|6|7|0|1|-285|13|-233|-289|-227|-283|-223|-279|-281|-254|-277|-250|-252|-1|-248|8|103|17|5|6|7|0|1|18|-15|17|5|6|7|0|8|8|104|17|5|6|7|0|1|18|-15|17|5|6|7|0|12|8|105|17|5|6|7|0|3|8|106|10|107|8|108|10|109|8|21|17|5|6|7|0|1|8|108|17|5|6|7|0|1|8|22|10|110|-321|-323|-313|-319|-309|-311|8|111|84|-287|8|80|17|5|6|7|0|3|8|81|10|112|8|83|84|19|13|8|21|17|5|6|7|0|1|8|81|17|5|6|7|0|1|8|22|10|113|-342|-344|-333|-340|-309|-331|8|31|10|114|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupiwnQ|760000000|8|41|10|61|8|42|39|62|TupjYCZ|8|43|10|115|-309|-352|8|46|10|65|8|48|10|65|8|50|10|65|8|51|10|"
    contents3 = "116|8|53|10|116|8|117|17|5|6|7|0|0|-309|-378|8|21|17|5|6|7|0|1|8|53|17|5|6|7|0|1|8|22|10|118|-384|-386|-309|-382|-305|-307|-301|-303|8|31|10|119|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|Tupiwmj|715000000|8|41|10|61|8|42|39|62|TupjYBr|8|43|10|115|-301|-394|8|48|10|65|8|50|10|65|8|120|17|5|6|7|0|0|-301|-414|8|51|10|121|8|53|10|121|-297|-299|-1|-295|8|122|17|5|6|7|0|2|18|-15|10|123|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|124|-430|-432|-424|-428|-1|-422|8|31|10|125|8|126|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|31|10|127|8|128|10|129|8|21|17|5|6|7|0|1|8|128|17|5|6|7|0|1|8|22|10|130|-454|-456|-446|-452|-442|-444|-1|-440|8|131|17|5|6|7|0|0|-1|-462|8|132|10|133|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|Tuphsnx|265000000|8|41|10|61|8|42|39|62|TupjYBD|8|43|10|134|-1|-468|8|135|13|-7|8|136|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|88|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|-223|17|5|6|7|0|1|-227|17|5|6|7|0|2|8|90|13|-233|8|91|13|-233|-503|-227|-500|-223|-508|10|93|-510|94|-247|-496|-498|-492|-494|8|21|17|5|6|7|0|2|8|92|13|-233|-223|17|5|6|7|0|1|-227|17|5|6|7|0|1|-518|13|-233|-521|-227|-516|-223|-492|-514|-488|-490|-1|-486|8|137|13|-7|8|138|10|139|8|48|10|65|8|50|10|65|8|140|10|141|8|120|17|5|6|7|0|2|18|-15|10|142|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|143|-545|-547|-539|-543|-1|-537|8|144|10|145|8|51|10|146|8|53|10|146|8|117|17|5|6|7|0|2|18|-15|10|147|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|148|-567|-569|-561|-565|-1|-559|8|149|17|5|6|7|0|2|18|-15|10|93|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|150|-583|-585|-577|-581|-1|-575|8|151|17|5|6|7|0|0|-1|-591|8|152|17|5|6|7|0|3|8|153|39|40|Tuphsnx|265000000|8|154|94|95|B|8|155|10|156|-1|-595|8|21|17|5|6|7|0|3|8|138|17|5|6|7|0|1|8|22|10|157|-609|-611|8|140|17|5|6|7|0|1|8|22|10|141|-609|-617|8|9|17|5|6|7|0|1|8|22|10|158|-609|-623|-1|-607|8|159|17|5|6|7|0|14|8|160|10|161|8|31|10|162|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TuphstT|619000000|8|41|10|61|8|42|39|62|TupjYYb|8|43|10|107|-631|-637|8|46|10|68|8|163|17|5|6|7|0|1|18|-15|10|125|-631|-655|8|164|10|165|8|166|17|5|6|7|0|0|-631|-663|8|167|17|5|6|7|0|0|-631|-667|8|168|17|5|6|7|0|2|8|57|10|169|8|59|10|169|-631|-671|8|48|10|170|8|50|10|170|8|51|10|171|8|53|10|171|8|172|10|173|-1|-629|8|174|17|5|6|7|0|1|8|175|17|5|6|7|0|0|-691|-693|-1|-689|0|0|"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "#{contents1}#{contents2}#{contents3}"
      },
      {
        'subst' => 'true',
        :dyn_variables => [
          {"name" => opts[:affliated_orgs_id_name], "re" => opts[:affliated_orgs_id_regexp]},
          {"name" => opts[:lab_fee_id_name], "re" => opts[:lab_fee_id_regexp]},
          {"name" => opts[:revenues_id_name], "re" => opts[:revenues_id_regexp]},
          {"name" => opts[:revenue_id_name], "re" => opts[:revenue_id_regexp]}
        ],
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    #@request.add("DEBUG/affliated_orgs_id_name/%%_#{opts[:affliated_orgs_id_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    #@request.add("DEBUG/lab_fee_id_name/%%_#{opts[:lab_fee_id_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    #@request.add("DEBUG/revenues_id_name/%%_#{opts[:revenues_id_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    #@request.add("DEBUG/revenue_id_name/%%_#{opts[:revenue_id_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    
    @request.add_thinktime(2)
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|isAuthorizedAddReviewer|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|isAuthorizedRemoveReviewers|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    
    
    #
    # Authors and Collaborators
    #
    # Enter "fran" and let it find the list.  Click on "fran, fran(fran)" and fill all fields: Permission = "Edit, Comment, View"; Action Request = "FYI"; Make sure "Add Author Notation" is selected for "Author Notation" and click "Add Collaborator"
    @request.add_thinktime(5)

    if(!opts[:collaborator].nil?)
      # Collaborator search
      for i in 1..opts[:collaborator].length
        itr = i-1
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "7|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1B96D688C516670F35919EED9331AFD6|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.r2.core.search.dto.SearchRequestInfo/252400467|java.lang.Boolean/476441737|java.util.ArrayList/4159755760|org.kuali.student.r2.core.search.dto.SearchParamInfo/2639056767|person.queryParam.personGivenName|java.lang.String/2004016611|#{opts[:collaborator][0..itr]}|person.queryParam.excludedUserId|#{opts[:propose_person]}|person.search.personQuickViewByGivenName|person.resultColumn.DisplayName|org.kuali.student.r2.core.search.dto.SortDirection/4233948822|1|2|3|4|1|5|5|0|0|6|0|7|2|8|0|9|7|1|10|11|8|0|12|7|1|10|13|14|15|16|0|0|"
          },
          {
            :custom_headers => {
              'X-GWT-Permutation' => "HostedMode"}
          }
        )    
      end

      @request.add_thinktime(5)

      contents1 = "7|0|194|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AE1778030A517746853EA607C05107A1|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.r1.common.assembly.data.Data/1485826496|org.kuali.student.r1.common.assembly.data.Data|java.util.LinkedHashMap/3008245022|org.kuali.student.r1.common.assembly.data.Data$StringKey/642388540|finalExamStatus|org.kuali.student.r1.common.assembly.data.Data$StringValue/223926985|STD|audit|org.kuali.student.r1.common.assembly.data.Data$BooleanValue/2980665104|java.lang.Boolean/476441737|passFail|campusLocations|org.kuali.student.r1.common.assembly.data.Data$DataValue/690845158|org.kuali.student.r1.common.assembly.data.Data$IntegerKey/2963918776|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|descr|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepositoryKey|kuali.loRepository.key.singleUse|meta|createId|admin|createTime|org.kuali.student.r1.common.assembly.data.Data$DateValue/2782133523|java.sql.Timestamp/3040052672|updateId|updateTime|versionInd|0|metaInfo|name|#{opts[:lo_category]}|state|active|stateKey|type|loCategoryType.subject|typeKey|loDisplayInfoList|loInfo|sequence|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|#{opts[:propose_person]}|java.util.Date/3385151746|2|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|key|kuali.creditType.credit.degree.10.0|resultValueKeys|resultValueRange|minValue|10|kuali.result.values.group.type.fixed|Fixed|crossListings|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.r1.common.assembly.data.Data$IntegerValue/2595436661|Semester|effectiveDate|expenditure|affiliatedOrgs|%%_#{opts[:affliated_orgs_id_name]}%%|orgId|%%_#{opts[:admin_dep_var_name]}%%|percentage|org.kuali.student.r1.common.assembly.data.Data$LongValue/3940989517|java.lang.Long/4227064769|#{admin_org}|fees|feeAmounts|currencyQuantity|currencyTypeKey|kuali.currency.typeKey.usdollars.cents|feeType|kuali.enum.type.feeTypes.labFee|%%_#{opts[:lab_fee_id_name]}%%|1|rateType|fixedRateFee|Fixed Rate Fee|Laboratory Fee|formats|activities|contactHours|unitQuantity|5|unitTypeKey|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|3|kuali.lu.type.activity.Lab|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|%%_#{opts[:instructor_id_var_name]}%%|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|pilotCourse|revenues|%%_#{opts[:revenues_id_name]}%%|REVENUE|%%_#{opts[:revenue_id_name]}%%|specialTopicsCourse|startTerm|20084|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|variations|version|currentVersionStart|sequenceNumber|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Fall 2008|Standard final Exam|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|6|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators|principalId|#{opts[:collaborator]}|permission|KS-SYS~Edit Document|action|F|firstName|lastName|actionRequestStatus|New|author"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|40|8|9|10|11|8|12|13|14|0|8|15|13|-7|8|16|17|5|6|7|0|2|18|19|0|10|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|23|-19|-21|-12|-17|-1|-10|8|24|10|25|8|26|10|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|10|8|30|17|5|6|7|0|0|-45|-47|8|31|10|32|8|33|10|34|8|35|17|5|6|7|0|5|8|36|10|37|8|38|39|40|SzgEBxI|0|8|41|10|37|8|42|39|40|SzgEBxI|0|8|43|10|44|-45|-55|8|45|17|5|6|7|0|5|8|36|10|37|8|38|39|-63|8|41|10|37|8|42|39|-68|8|43|10|44|-45|-71|8|46|10|47|8|48|10|49|8|50|10|49|8|51|10|52|8|53|10|52|-41|-43|-37|-39|8|54|17|5|6|7|0|0|-37|-95|8|55|17|5|6|7|0|10|8|56|10|44|8|30|17|5|6|7|0|2|8|57|10|58|8|59|10|58|-101|-105|8|31|10|60|8|33|10|34|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupjA9P|703000000|8|41|10|61|8|42|39|62|TupjkhL|8|43|10|63|-101|-117|8|46|10|64|8|48|10|65|8|50|10|65|8|51|10|66|8|53|10|66|-37|-99|-33|-35|-1|-31|8|67|10|68|8|69|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|70|10|71|8|72|17|5|6|7|0|0|-151|-155|8|73|17|5|6|7|0|1|8|74|10|75|-151|-159|8|51|10|76|8|53|10|76|8|21|17|5|6|7|0|1|8|53|17|5|6|7|0|1|8|22|10|77|-171|-173|-151|-169|-147|-149|-1|-145|8|78|17|5|6|7|0|0|-1|-179|8|30|17|5|6|7|0|1|8|59|10|79|-1|-183|8|80|17|5|6|7|0|3|8|81|10|82|8|83|84|19|2|8|21|17|5|6|7|0|1|8|81|17|5|6|7|0|1|8|22|10|85|-200|-202|-191|-198|-1|-189|8|86|39|40|RySg3IA|0|8|87|17|5|6|7|0|1|8|88|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|31|10|89|8|90|10|91|8|92|93|94|Bk|8|21|17|5|6|7|0|1|8|90|17|5|6|7|0|1|8|22|10|95|-232|-234|-221|-230|-217|-219|-213|-215|-1|-211|8|96|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|97|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|98|84|19|100|8|99|10|100|-250|-252|-246|-248|8|101|10|102|8|31|10|103|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|62|TupjkeZ|8|41|10|61|8|42|39|62|Tupjkec|8|43|10|104|-246|-265|8|105|10|106|8|21|17|5|6|7|0|2|8|105|17|5|6|7|0|1|8|22|10|107|-285|-287|8|101|17|5|6|7|0|1|8|22|10|108|-285|-293|-246|-283|-242|-244|-1|-240|8|109|17|5|6|7|0|1|18|-15|17|5|6|7|0|8|8|110|17|5|6|7|0|1|18|-15|17|5|6|7|0|12|8|111|17|5|6|7|0|3|8|112|10|113|8|114|10|115|8|21|17|5|6|7|0|1|8|114|17|5|6|7|0|1|8|22|10|116|-325|-327|-317|-323|-313|-315|8|117|84|-258|8|80|17|5|6|7|0|3|8|81|10|118|8|83|84|19|13|8|21|17|5|6|7|0|1|8|81|17|5|6|7|0|1|8|22|10|119|-346|-348|-337|-344|-313|-335|8|31|10|120|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupiwnQ|760000000|8|41|10|61|8|42|39|62|Tupjkf8|8|43|10|121|-313|-356|8|46|10|65|8|48|10|65|8|50|10|65|8|51|10|122|8|53|10|122|8|123|17|5|6|7"
      contents3 = "|0|0|-313|-382|8|21|17|5|6|7|0|1|8|53|17|5|6|7|0|1|8|22|10|124|-388|-390|-313|-386|-309|-311|-305|-307|8|31|10|125|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|Tupiwmj|715000000|8|41|10|61|8|42|39|62|Tupjkfa|8|43|10|121|-305|-398|8|48|10|65|8|50|10|65|8|126|17|5|6|7|0|0|-305|-418|8|51|10|127|8|53|10|127|-301|-303|-1|-299|8|128|17|5|6|7|0|2|18|-15|10|129|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|130|-434|-436|-428|-432|-1|-426|8|31|10|131|8|132|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|31|10|133|8|134|10|135|8|21|17|5|6|7|0|1|8|134|17|5|6|7|0|1|8|22|10|136|-458|-460|-450|-456|-446|-448|-1|-444|8|137|17|5|6|7|0|0|-1|-466|8|138|10|139|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|Tuphsnx|265000000|8|41|10|61|8|42|39|62|Tupjkeb|8|43|10|113|-1|-472|8|140|13|-7|8|141|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|88|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|31|10|142|8|90|10|91|8|92|93|-229|8|21|17|5|6|7|0|1|8|90|17|5|6|7|0|1|8|22|10|95|-514|-516|-504|-512|-500|-502|-496|-498|8|101|10|143|8|31|10|144|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|62|TupjkeZ|8|41|10|61|8|42|39|62|Tupjkec|8|43|10|104|-496|-526|-492|-494|-1|-490|8|145|13|-7|8|146|10|147|8|48|10|65|8|50|10|65|8|148|10|149|8|126|17|5|6|7|0|2|18|-15|10|150|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|151|-560|-562|-554|-558|-1|-552|8|152|10|153|8|51|10|154|8|53|10|154|8|123|17|5|6|7|0|2|18|-15|10|155|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|156|-582|-584|-576|-580|-1|-574|8|157|17|5|6|7|0|2|18|-15|10|91|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|95|-598|-600|-592|-596|-1|-590|8|158|17|5|6|7|0|0|-1|-606|8|159|17|5|6|7|0|3|8|160|39|40|Tuphsnx|265000000|8|161|93|94|B|8|162|10|163|-1|-610|8|21|17|5|6|7|0|3|8|146|17|5|6|7|0|1|8|22|10|164|-624|-626|8|148|17|5|6|7|0|1|8|22|10|149|-624|-632|8|9|17|5|6|7|0|1|8|22|10|165|-624|-638|-1|-622|8|166|17|5|6|7|0|14|8|167|10|168|8|31|10|169|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TuphstT|619000000|8|41|10|61|8|42|39|62|Tupjkya|8|43|10|170|-646|-652|8|46|10|68|8|171|17|5|6|7|0|1|18|-15|10|131|-646|-670|8|172|10|173|8|174|17|5|6|7|0|0|-646|-678|8|175|17|5|6|7|0|0|-646|-682|8|176|17|5|6|7|0|2|8|57|10|177|8|59|10|177|-646|-686|8|48|10|178|8|50|10|178|8|51|10|179|8|53|10|179|8|180|10|181|-1|-644|8|182|17|5|6|7|0|1|8|183|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|184|10|185|8|186|10|187|8|188|10|189|8|190|10|185|8|191|10|185|8|192|10|193|8|194|13|14|1|-710|-712|-706|-708|-1|-704|0|0|"
    else
      # UPDATE
      contents1 = "7|0|179|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|D60D3C6E0D395C18A0F44A2D9D2A7348|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepository|kuali.loRepository.key.singleUse|metaInfo|createId|#{opts[:propose_person]}|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|0|name|#{opts[:lo_category]}|state|active|type|loCategoryType.subject|loDisplayInfoList|loInfo|sequence|desc|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|loRepositoryKey|#{opts[:propose_person]}|2|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|fixedCreditValue|10.0|kuali.creditType.credit.degree.10.0|resultValues|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|%%_#{opts[:affliated_orgs_id_name]}%%|orgId|%%_#{opts[:admin_dep_var_name]}%%|percentage|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|#{admin_org}|fees|feeAmounts|currencyQuantity|currencyTypeKey|kuali.currency.type.usdollars.cents|feeType|kuali.enum.type.feeTypes.labFee|%%_#{opts[:lab_fee_id_name]}%%|1|rateType|fixedRateFee|Fixed Rate Fee|Laboratory Fee|formats|activities|activityType|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|3|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|pilotCourse|revenues|%%_#{opts[:revenues_id_name]}%%|REVENUE|%%_#{opts[:revenue_id_name]}%%|specialTopicsCourse|startTerm|kuali.atp.FA2008-2009|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|variations|versionInfo|currentVersionStart|sequenceNumber|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Fall Semester of 2008|Standard final Exam|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|7|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|0|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|30|14|31|8|32|14|33|8|34|17|5|6|7|0|5|8|35|14|36|8|37|38|39|3759152200|1288490188800|0|8|40|14|36|8|41|38|39|3759152200|1288490188800|0|8|42|14|43|-45|-51|8|44|14|45|8|46|14|47|8|48|14|49|-41|-43|-37|-39|8|50|17|5|6|7|0|0|-37|-73|8|51|17|5|6|7|0|8|8|52|14|43|8|53|17|5|6|7|0|2|8|54|14|55|8|56|14|55|-79|-83|8|30|14|57|8|58|14|33|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3491266071|1309965025280|351000000|8|40|14|59|8|41|38|39|3491272352|1309965025280|632000000|8|42|14|60|-79|-95|8|44|14|61|8|46|14|62|8|48|14|63|-37|-77|-33|-35|-1|-31|8|64|14|65|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|67|14|68|8|30|14|69|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3479039543|1309965025280|823000000|8|40|14|59|8|41|38|39|3479039543|1309965025280|823000000|8|42|14|43|-125|-131|8|70|17|5|6|7|0|1|18|-15|14|68|-125|-147|8|46|14|62|8|48|14|71|8|21|17|5|6|7|0|1|8|48|17|5|6|7|0|1|8|22|14|72|-159|-161|-125|-157|-121|-123|-1|-119|8|73|17|5|6|7|0|0|-1|-167|8|74|17|5|6|7|0|1|8|56|14|75|-1|-171|8|76|17|5|6|7|0|3|8|77|14|78|8|79|80|19|2|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|81|-188|-190|-179|-186|-1|-177|8|82|38|39|470887936|1219770712064|0|8|83|17|5|6|7|0|1|8|84|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|30|14|85|8|86|14|87|8|88|89|90|100|0|8|21|17|5|6|7|0|1|8|86|17|5|6|7|0|1|8|22|14|91|-220|-222|-209|-218|-205|-207|-201|-203|-1|-199|8|92|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|93|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|94|80|19|100|8|95|14|96|-238|-240|-234|-236|8|97|14|98|8|30|14|99|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3491272235|1309965025280|515000000|8|40|14|59|8|41|38|39|3491272236|1309965025280|516000000|8|42|14|100|-234|-253|8|101|14|102|8|21|17|5|6|7|0|2|8|101|17|5|6|7|0|1|8|22|14|103|-273|-275|8|97|17|5|6|7|0|1|8|22|14|104|-273|-281|-234|-271|-230|-232|-1|-228|8|105|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|106|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|107|14|108|8|109|17|5|6|7|0|3|8|110|14|111|8|112|14|113|8|21|17|5|6|7|0|1|8|112|17|5|6|7|0|1|8|22|14|114|-315|-317|-307|-313|-301|-305|8|115|80|-246|8|76|17|5|6|7|0|3|8|77|14|116|8|79|80|19|13|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|117|-336|-338|-327|-334|-301|-325|8|30|14|118|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3491262219|1309965025280|499000000|8|40|14|59|8|41|38|39|3491272295|1309965025280|575000000|8|42|14|119|-301|-346|8|46|14|62|8|120|17|5|6|7|0|0|-301|-364|8|21|17|5|6|7|0|1|8|107|17|5|6|7|0|1|8|22|14|121|-370|-372|-301|-368|-297|-299|-293|-295|8|30|14|122|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3491262210|1309965025280|490000000|8|40|14|59|8|41|38|39|3491272289|1309965025280|569000000|8|42|14|119|-293|-380|8|46|14|62|8|123|17|5|6|7|0|0|-293|-398|8|48|14|124|-289|-291|-1|-287|8|125|17|5|6|7|0|2|18|-15|14|126|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|127|-412|-414|-406|-410|-1|-404|8|30|14|128|8|129|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|130|14|131|8|21|17|5|6|7|0|1|8|130|17|5|6|7|0|1|8|22|14|132|-434|-436|-428"
      contents3 = "|-432|-424|-426|-1|-422|8|133|17|5|6|7|0|0|-1|-442|8|134|14|135|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3491257291|1309965025280|571000000|8|40|14|59|8|41|38|39|3491272236|1309965025280|516000000|8|42|14|111|-1|-448|8|136|10|-5|8|137|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|84|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|30|14|138|8|86|14|87|8|88|89|90|100|0|8|21|17|5|6|7|0|1|8|86|17|5|6|7|0|1|8|22|14|91|-491|-493|-480|-489|-476|-478|-472|-474|8|97|14|139|8|30|14|140|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3491272233|1309965025280|513000000|8|40|14|59|8|41|38|39|3491272236|1309965025280|516000000|8|42|14|100|-472|-503|-468|-470|-1|-466|8|141|10|-5|8|142|14|143|8|46|14|62|8|144|14|145|8|123|17|5|6|7|0|2|18|-15|14|146|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|147|-535|-537|-529|-533|-1|-527|8|148|14|149|8|48|14|150|8|120|17|5|6|7|0|2|18|-15|14|151|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|152|-555|-557|-549|-553|-1|-547|8|153|17|5|6|7|0|2|18|-15|14|87|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|91|-571|-573|-565|-569|-1|-563|8|154|17|5|6|7|0|0|-1|-579|8|155|17|5|6|7|0|3|8|156|38|39|3491257291|1309965025280|571000000|8|157|89|90|1|0|8|158|14|159|-1|-583|8|21|17|5|6|7|0|3|8|142|17|5|6|7|0|1|8|22|14|160|-597|-599|8|144|17|5|6|7|0|1|8|22|14|145|-597|-605|8|13|17|5|6|7|0|1|8|22|14|161|-597|-611|-1|-595|8|162|17|5|6|7|0|12|8|163|14|164|8|30|14|165|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3491257553|1309965025280|833000000|8|40|14|59|8|41|38|39|3491273130|1309965025280|410000000|8|42|14|166|-619|-625|8|44|14|65|8|167|17|5|6|7|0|1|18|-15|14|128|-619|-643|8|168|14|169|8|170|17|5|6|7|0|0|-619|-651|8|171|17|5|6|7|0|0|-619|-655|8|172|14|173|8|46|14|174|8|48|14|175|8|176|14|177|-1|-617|8|178|17|5|6|7|0|1|8|179|17|5|6|7|0|0|-669|-671|-1|-667|0|0|"
    end

    # Save & Continue
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "#{contents1}#{contents2}#{contents3}"
      },
      {
        'subst' => 'true',
        :dyn_variables => [
          {"name" => opts[:action_request_id_name], "re" => opts[:action_request_id_regexp]}
        ],
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"}
      }
    )

    
    #@request.add("DEBUG/action_request_id_name/%%_#{opts[:action_request_id_name]}%%", {}, {'subst' => 'true', :custom_headers => {'X-GWT-Permutation' => "HostedMode"}})
    
    @request.add_thinktime(2)
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|BAB58DB0722A4A9369131304184968D0|org.kuali.student.core.document.ui.client.service.DocumentRpcService|getDocumentTypes|1|2|3|4|0|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|BAB58DB0722A4A9369131304184968D0|org.kuali.student.core.document.ui.client.service.DocumentRpcService|isAuthorizedUploadDocuments|java.lang.String/2004016611|%%_#{opts[:proposal_dyn_var_name]}%%|referenceType.clu.proposal|1|2|3|4|2|5|5|6|7|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|BAB58DB0722A4A9369131304184968D0|org.kuali.student.core.document.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:proposal_dyn_var_name]}%%|1|2|3|4|2|5|5|6|7|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    
    
    #
    # Support Documents
    # Nothing uploaded
    #

    @request.add_thinktime(5)

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|BAB58DB0722A4A9369131304184968D0|org.kuali.student.core.document.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:proposal_dyn_var_name]}%%|1|2|3|4|2|5|5|6|7|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )


    if(!opts[:collaborator].nil?)
      contents1 = "7|0|198|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3F980EEE5504E0742F014B8BB23B3D45|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|validate|org.kuali.student.r1.common.assembly.data.Data/1485826496|org.kuali.student.r1.common.assembly.data.Data|java.util.LinkedHashMap/3008245022|org.kuali.student.r1.common.assembly.data.Data$StringKey/642388540|finalExamStatus|org.kuali.student.r1.common.assembly.data.Data$StringValue/223926985|STD|audit|org.kuali.student.r1.common.assembly.data.Data$BooleanValue/2980665104|java.lang.Boolean/476441737|passFail|campusLocations|org.kuali.student.r1.common.assembly.data.Data$DataValue/690845158|org.kuali.student.r1.common.assembly.data.Data$IntegerKey/2963918776|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|descr|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepositoryKey|kuali.loRepository.key.singleUse|meta|createId|admin|createTime|org.kuali.student.r1.common.assembly.data.Data$DateValue/2782133523|java.sql.Timestamp/3040052672|updateId|updateTime|versionInd|0|metaInfo|name|#{opts[:lo_category]}|state|active|stateKey|type|loCategoryType.subject|typeKey|loDisplayInfoList|loInfo|sequence|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|#{opts[:propose_person]}|java.util.Date/3385151746|3|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|key|kuali.creditType.credit.degree.10.0|resultValueKeys|resultValueRange|minValue|10|kuali.result.values.group.type.fixed|Fixed|crossListings|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.r1.common.assembly.data.Data$IntegerValue/2595436661|Semester|effectiveDate|expenditure|affiliatedOrgs|%%_#{opts[:affliated_orgs_id_name]}%%|orgId|%%_#{opts[:admin_dep_var_name]}%%|percentage|org.kuali.student.r1.common.assembly.data.Data$LongValue/3940989517|java.lang.Long/4227064769|#{admin_org}|fees|feeAmounts|currencyQuantity|currencyTypeKey|kuali.currency.typeKey.usdollars.cents|feeType|kuali.enum.type.feeTypes.labFee|%%_#{opts[:lab_fee_id_name]}%%|2|rateType|fixedRateFee|Fixed Rate Fee|Laboratory Fee|formats|activities|contactHours|unitQuantity|5|unitTypeKey|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|4|kuali.lu.type.activity.Lab|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|%%_#{opts[:instructor_id_var_name]}%%|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|6|pilotCourse|revenues|%%_#{opts[:revenues_id_name]}%%|REVENUE|%%_#{opts[:revenue_id_name]}%%|specialTopicsCourse|startTerm|20084|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|variations|version|currentVersionStart|sequenceNumber|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Fall 2008|Standard final Exam|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|8|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|#{opts[:collaborator]}|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators|action|F|actionRequestId|%%_#{opts[:action_request_id_name]}%%|actionRequestStatus|INITIALIZED|author|canRevokeRequest|firstName|lastName|permission|KS-SYS~Edit Document|principalId"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|40|8|9|10|11|8|12|13|14|0|8|15|13|-7|8|16|17|5|6|7|0|2|18|19|0|10|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|23|-19|-21|-12|-17|-1|-10|8|24|10|25|8|26|10|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|10|8|30|17|5|6|7|0|0|-45|-47|8|31|10|32|8|33|10|34|8|35|17|5|6|7|0|5|8|36|10|37|8|38|39|40|SzgEBxI|0|8|41|10|37|8|42|39|40|SzgEBxI|0|8|43|10|44|-45|-55|8|45|17|5|6|7|0|5|8|36|10|37|8|38|39|-63|8|41|10|37|8|42|39|-68|8|43|10|44|-45|-71|8|46|10|47|8|48|10|49|8|50|10|49|8|51|10|52|8|53|10|52|-41|-43|-37|-39|8|54|17|5|6|7|0|0|-37|-95|8|55|17|5|6|7|0|10|8|56|10|44|8|30|17|5|6|7|0|2|8|57|10|58|8|59|10|58|-101|-105|8|31|10|60|8|33|10|34|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupjA9P|703000000|8|41|10|61|8|42|39|62|TupjvJD|8|43|10|63|-101|-117|8|46|10|64|8|48|10|65|8|50|10|65|8|51|10|66|8|53|10|66|-37|-99|-33|-35|-1|-31|8|67|10|68|8|69|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|70|10|71|8|72|17|5|6|7|0|0|-151|-155|8|73|17|5|6|7|0|1|8|74|10|75|-151|-159|8|51|10|76|8|53|10|76|8|21|17|5|6|7|0|1|8|53|17|5|6|7|0|1|8|22|10|77|-171|-173|-151|-169|-147|-149|-1|-145|8|78|17|5|6|7|0|0|-1|-179|8|30|17|5|6|7|0|1|8|59|10|79|-1|-183|8|80|17|5|6|7|0|3|8|81|10|82|8|83|84|19|2|8|21|17|5|6|7|0|1|8|81|17|5|6|7|0|1|8|22|10|85|-200|-202|-191|-198|-1|-189|8|86|39|40|RySg3IA|0|8|87|17|5|6|7|0|1|8|88|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|31|10|89|8|90|10|91|8|92|93|94|Bk|8|21|17|5|6|7|0|1|8|90|17|5|6|7|0|1|8|22|10|95|-232|-234|-221|-230|-217|-219|-213|-215|-1|-211|8|96|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|97|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|98|84|19|100|8|99|10|100|-250|-252|-246|-248|8|101|10|102|8|31|10|103|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupjkeZ|185000000|8|41|10|61|8|42|39|62|TupjvGP|8|43|10|104|-246|-265|8|105|10|106|8|21|17|5|6|7|0|2|8|105|17|5|6|7|0|1|8|22|10|107|-285|-287|8|101|17|5|6|7|0|1|8|22|10|108|-285|-293|-246|-283|-242|-244|-1|-240|8|109|17|5|6|7|0|1|18|-15|17|5|6|7|0|8|8|110|17|5|6|7|0|1|18|-15|17|5|6|7|0|12|8|111|17|5|6|7|0|3|8|112|10|113|8|114|10|115|8|21|17|5|6|7|0|1|8|114|17|5|6|7|0|1|8|22|10|116|-325|-327|-317|-323|-313|-315|8|117|84|-258|8|80|17|5|6|7|0|3|8|81|10|118|8|83|84|19|13|8|21|17|5|6|7|0|1|8|81|17|5|6|7|0|1|8|22|10|119|-346|-348|-337|-344|-313|-335|8|31|10|120|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupiwnQ|760000000|8|41|10|61|8|42|39|62|TupjvIA|8|43|10|121|-313|-356|8|46|10|65|8|48|10|65|8|50|10|65|8|51|10|122|8|53|10|122|8|123|17|5|6|7|0|0|-313|-382|8|21|17|5|6|7|0|1|8|53|17"
      contents3 = "|5|6|7|0|1|8|22|10|124|-388|-390|-313|-386|-309|-311|-305|-307|8|31|10|125|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|Tupiwmj|715000000|8|41|10|61|8|42|39|62|TupjvHj|8|43|10|121|-305|-398|8|48|10|65|8|50|10|65|8|126|17|5|6|7|0|0|-305|-418|8|51|10|127|8|53|10|127|-301|-303|-1|-299|8|128|17|5|6|7|0|2|18|-15|10|129|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|130|-434|-436|-428|-432|-1|-426|8|31|10|131|8|132|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|31|10|133|8|134|10|135|8|21|17|5|6|7|0|1|8|134|17|5|6|7|0|1|8|22|10|136|-458|-460|-450|-456|-446|-448|-1|-444|8|137|17|5|6|7|0|0|-1|-466|8|138|10|139|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|Tuphsnx|265000000|8|41|10|61|8|42|39|62|TupjvGO|8|43|10|140|-1|-472|8|141|13|-7|8|142|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|88|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|31|10|143|8|90|10|91|8|92|93|-229|8|21|17|5|6|7|0|1|8|90|17|5|6|7|0|1|8|22|10|95|-514|-516|-504|-512|-500|-502|-496|-498|8|101|10|144|8|31|10|145|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TupjkeZ|185000000|8|41|10|61|8|42|39|62|TupjvGP|8|43|10|104|-496|-526|-492|-494|-1|-490|8|146|13|-7|8|147|10|148|8|48|10|65|8|50|10|65|8|149|10|150|8|126|17|5|6|7|0|2|18|-15|10|151|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|152|-560|-562|-554|-558|-1|-552|8|153|10|154|8|51|10|155|8|53|10|155|8|123|17|5|6|7|0|2|18|-15|10|156|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|157|-582|-584|-576|-580|-1|-574|8|158|17|5|6|7|0|2|18|-15|10|91|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|10|95|-598|-600|-592|-596|-1|-590|8|159|17|5|6|7|0|0|-1|-606|8|160|17|5|6|7|0|3|8|161|39|40|Tuphsnx|265000000|8|162|93|94|B|8|163|10|164|-1|-610|8|21|17|5|6|7|0|3|8|147|17|5|6|7|0|1|8|22|10|165|-624|-626|8|149|17|5|6|7|0|1|8|22|10|150|-624|-632|8|9|17|5|6|7|0|1|8|22|10|166|-624|-638|-1|-622|8|167|17|5|6|7|0|14|8|168|10|169|8|31|10|170|8|35|17|5|6|7|0|5|8|36|10|61|8|38|39|40|TuphstT|619000000|8|41|10|61|8|42|39|62|TupjwDA|8|43|10|171|-646|-652|8|46|10|68|8|172|17|5|6|7|0|1|18|-15|10|131|-646|-670|8|173|10|174|8|175|17|5|6|7|0|0|-646|-678|8|176|17|5|6|7|0|1|18|-15|10|177|-646|-682|8|178|17|5|6|7|0|2|8|57|10|179|8|59|10|179|-646|-688|8|48|10|180|8|50|10|180|8|51|10|181|8|53|10|181|8|182|10|183|-1|-644|8|184|17|5|6|7|0|1|8|185|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|186|10|187|8|188|10|189|8|190|10|191|8|192|13|14|1|8|193|13|-726|8|194|10|177|8|195|10|177|8|196|10|197|8|198|10|177|-712|-714|-708|-710|-1|-706|0|0|"
    else
      #UPDATE
      contents1 = "7|0|180|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|1ED48DA6F48F82765FE7B58378EA94E0|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|validate|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepository|kuali.loRepository.key.singleUse|metaInfo|createId|#{opts[:propose_person]}|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|0|name|#{opts[:lo_category]}|state|active|type|loCategoryType.subject|loDisplayInfoList|loInfo|sequence|desc|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|loRepositoryKey|#{opts[:propose_person]}|3|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|fixedCreditValue|10.0|kuali.creditType.credit.degree.10.0|resultValues|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|%%_#{opts[:affliated_orgs_id_name]}%%|orgId|%%_#{opts[:admin_dep_var_name]}%%|percentage|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|#{admin_org}|fees|feeAmounts|currencyQuantity|currencyTypeKey|kuali.currency.type.usdollars.cents|feeType|kuali.enum.type.feeTypes.labFee|%%_#{opts[:lab_fee_id_name]}%%|2|rateType|fixedRateFee|Fixed Rate Fee|Laboratory Fee|formats|activities|activityType|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|4|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|6|pilotCourse|revenues|%%_#{opts[:revenues_id_name]}%%|REVENUE|%%_#{opts[:revenue_id_name]}%%|specialTopicsCourse|startTerm|kuali.atp.FA2008-2009|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|#{opts[:oversight_dept_number]}|#{oversight_department}|unitsDeployment|variations|versionInfo|currentVersionStart|sequenceNumber|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Fall Semester of 2008|Standard final Exam|proposal|workflowNode|PreRoute|%%_#{opts[:proposal_dyn_var_name]}%%|8|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|0|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|30|14|31|8|32|14|33|8|34|17|5|6|7|0|5|8|35|14|36|8|37|38|39|3759152200|1288490188800|0|8|40|14|36|8|41|38|39|3759152200|1288490188800|0|8|42|14|43|-45|-51|8|44|14|45|8|46|14|47|8|48|14|49|-41|-43|-37|-39|8|50|17|5|6|7|0|0|-37|-73|8|51|17|5|6|7|0|8|8|52|14|43|8|53|17|5|6|7|0|2|8|54|14|55|8|56|14|55|-79|-83|8|30|14|57|8|58|14|33|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3498783321|1309965025280|601000000|8|40|14|59|8|41|38|39|3498791687|1309965025280|967000000|8|42|14|60|-79|-95|8|44|14|61|8|46|14|62|8|48|14|63|-37|-77|-33|-35|-1|-31|8|64|14|65|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|67|14|68|8|30|14|69|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3479039543|1309965025280|823000000|8|40|14|59|8|41|38|39|3479039543|1309965025280|823000000|8|42|14|43|-125|-131|8|70|17|5|6|7|0|1|18|-15|14|68|-125|-147|8|46|14|62|8|48|14|71|8|21|17|5|6|7|0|1|8|48|17|5|6|7|0|1|8|22|14|72|-159|-161|-125|-157|-121|-123|-1|-119|8|73|17|5|6|7|0|0|-1|-167|8|74|17|5|6|7|0|1|8|56|14|75|-1|-171|8|76|17|5|6|7|0|3|8|77|14|78|8|79|80|19|2|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|81|-188|-190|-179|-186|-1|-177|8|82|38|39|470887936|1219770712064|0|8|83|17|5|6|7|0|1|8|84|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|30|14|85|8|86|14|87|8|88|89|90|100|0|8|21|17|5|6|7|0|1|8|86|17|5|6|7|0|1|8|22|14|91|-220|-222|-209|-218|-205|-207|-201|-203|-1|-199|8|92|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|93|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|94|80|19|100|8|95|14|96|-238|-240|-234|-236|8|97|14|98|8|30|14|99|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3498789104|1309965025280|384000000|8|40|14|59|8|41|38|39|3498791612|1309965025280|892000000|8|42|14|100|-234|-253|8|101|14|102|8|21|17|5|6|7|0|2|8|101|17|5|6|7|0|1|8|22|14|103|-273|-275|8|97|17|5|6|7|0|1|8|22|14|104|-273|-281|-234|-271|-230|-232|-1|-228|8|105|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|106|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|107|14|108|8|109|17|5|6|7|0|3|8|110|14|111|8|112|14|113|8|21|17|5|6|7|0|1|8|112|17|5|6|7|0|1|8|22|14|114|-315|-317|-307|-313|-301|-305|8|115|80|-246|8|76|17|5|6|7|0|3|8|77|14|116|8|79|80|19|13|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|117|-336|-338|-327|-334|-301|-325|8|30|14|118|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3498779786|1309965025280|66000000|8|40|14|59|8|41|38|39|3498791652|1309965025280|932000000|8|42|14|119|-301|-346|8|46|14|62|8|120|17|5|6|7|0|0|-301|-364|8|21|17|5|6|7|0|1|8|107|17|5|6|7|0|1|8|22|14|121|-370|-372|-301|-368|-297|-299|-293|-295|8|30|14|122|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3498779778|1309965025280|58000000|8|40|14|59|8|41|38|39|3498791646|1309965025280|926000000|8|42|14|119|-293|-380|8|46|14|62|8|123|17|5|6|7|0|0|-293|-398|8|48|14|124|-289|-291|-1|-287|8|125|17|5|6|7|0|2|18|-15|14|126|8|21|17|5|6"
      contents3 = "|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|127|-412|-414|-406|-410|-1|-404|8|30|14|128|8|129|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|130|14|131|8|21|17|5|6|7|0|1|8|130|17|5|6|7|0|1|8|22|14|132|-434|-436|-428|-432|-424|-426|-1|-422|8|133|17|5|6|7|0|0|-1|-442|8|134|14|135|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3498775348|1309965025280|628000000|8|40|14|59|8|41|38|39|3498791612|1309965025280|892000000|8|42|14|136|-1|-448|8|137|10|-5|8|138|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|84|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|30|14|139|8|86|14|87|8|88|89|90|100|0|8|21|17|5|6|7|0|1|8|86|17|5|6|7|0|1|8|22|14|91|-491|-493|-480|-489|-476|-478|-472|-474|8|97|14|140|8|30|14|141|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3498789104|1309965025280|384000000|8|40|14|59|8|41|38|39|3498791612|1309965025280|892000000|8|42|14|100|-472|-503|-468|-470|-1|-466|8|142|10|-5|8|143|14|144|8|46|14|62|8|145|14|146|8|123|17|5|6|7|0|2|18|-15|14|147|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|148|-535|-537|-529|-533|-1|-527|8|149|14|150|8|48|14|151|8|120|17|5|6|7|0|2|18|-15|14|152|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|153|-555|-557|-549|-553|-1|-547|8|154|17|5|6|7|0|2|18|-15|14|87|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|91|-571|-573|-565|-569|-1|-563|8|155|17|5|6|7|0|0|-1|-579|8|156|17|5|6|7|0|3|8|157|38|39|3498775348|1309965025280|628000000|8|158|89|90|1|0|8|159|14|160|-1|-583|8|21|17|5|6|7|0|3|8|143|17|5|6|7|0|1|8|22|14|161|-597|-599|8|145|17|5|6|7|0|1|8|22|14|146|-597|-605|8|13|17|5|6|7|0|1|8|22|14|162|-597|-611|-1|-595|8|163|17|5|6|7|0|12|8|164|14|165|8|30|14|166|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|3498775596|1309965025280|876000000|8|40|14|59|8|41|38|39|3498792455|1309965025280|735000000|8|42|14|167|-619|-625|8|44|14|65|8|168|17|5|6|7|0|1|18|-15|14|128|-619|-643|8|169|14|170|8|171|17|5|6|7|0|0|-619|-651|8|172|17|5|6|7|0|0|-619|-655|8|173|14|174|8|46|14|175|8|48|14|176|8|177|14|178|-1|-617|8|179|17|5|6|7|0|1|8|180|17|5|6|7|0|0|-669|-671|-1|-667|0|0|"
    end
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "#{contents1}#{contents2}#{contents3}"
      },
      {
        'subst' => 'true',
        :custom_headers => {
          'X-GWT-Permutation' => "HostedMode"
        }
      }
    )

    @request.add_thinktime(5)


    # Submit to worflow
    if(opts[:submit])
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|submitDocumentWithId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true',
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"
          }
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true',
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"
          }
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A2529192F6533F3E778C0623B2EADEFA|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true',
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"
          }
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5163A5427A75B2D7094860634E74B176|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true',
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"
          }
        }
      )
      
    end
    
    
  end
  
  
  
  def scratch
    
    
  end
  
  
  # Currently not working in 1.1
  def edit_proposal(proposal_name, opts={})
    
    defaults = {
      :proposal_id_dyn_var => 'ep_proposal_id',
      :proposal_id_regexp => 'proposal.resultColumn.proposalId\"\,\"([^\"]+)',
      #:proposal_dyn_var => 'ep_proposal',
      #:proposal_regexp => 'proposal\"\,\"([^\"]+)',
      :proposal_num_dyn_var => 'ep_proposal_num',
      :proposal_num_regexp => 'proposal\"\,\"[^\"]+\"\,\"([^\"]+)',
      :workflow_id_dyn_var => 'ep_workflow_id',
      :workflow_id_regexp => 'workflowId\"\,\"([^\"]+)',
      :id_translation_id_dyn_var => 'ep_id_translation_id',
      :id_translation_id_regexp => 'id-translation\"\,\"([^\"]+)',
      :code_dyn_var => 'ep_code',
      :code_regexp => 'code\"\,\"([^\"]+)',
      :course_num_suffix_dyn_var => 'ep_course_num_suffix',
      :course_num_suffix_regexp => 'courseNumberSuffix\"\,\"([^\"]+)',
      :lo_category_id_dyn_var => 'ep_lo_cat_id',
      :lo_category_id_regexp => 'expirationDate\"\,\"id\"\,\"([^\"]+)',
      :lo_category_dyn_var => 'ep_lo_cat',
      :lo_category_regexp => 'name\"\,\"([^\"]+)',
      :lo_cat_text_dyn_var => 'ep_lo_cat_text',
      :lo_cat_text_regexp => 'loInfo\"\,\"sequence\"\,\"0\"\,\"([^\"]+)',
      :lo_cat_id_dyn_var => 'ep_lo_cat_id',
      :lo_cat_id_regexp => '([^\"]+)\"\,\"loRepositoryKey',
      :create_id_dyn_var => 'ep_create_id',
      :create_id_regexp => 'createId\"\,\"([^\"]+)',
      :course_title_dyn_var => 'ep_course_title',
      :course_title_regexp => 'courseTitle\"\,\"([^\"]+)',
      :oversight_org_dyn_var => 'ep_oversight_org',
      :oversight_org_regexp => 'curriculumOversightOrgs\"\,\"[^\,]+\,\"([^\"]+)',
      :lab_fee_id_dyn_var => 'ep_lab_fee_id',
      :lab_fee_id_regexp => 'kuali.enum.type.feeTypes.labFee\"\,\"([^\"]+)',
      :atp_dur_week_id_dyn_var => 'ep_atp_dur_week_id',
      :atp_dur_week_id_regexp => 'kuali.atp.duration.Week\"\,\"Week\"\,\"([^\"]+)',
      :lab_id_dyn_var => 'ep_lab_id',
      :lab_id_regexp => 'Lab\"\,\"([^\"]+)',
      :grade_id_dyn_var => 'ep_grade_id',
      :grade_id_regexp => 'kuali.resultComponent.grade[^\,]+\,\"[^\,]+\,\"([^\"]+)',
      :person_id_dyn_var => 'ep_person_id',
      :person_id_regexp => 'personId\"\,\"([^\"]+)',
      :joints_dyn_var => 'ep_joints',
      :joints_regexp => 'joints\"\,\"([^\"]+)',
      :subject_area_dyn_var => 'ep_subject_area',
      :subject_area_regexp => 'subjectArea\"\,\"([^\"]+)',
      :title_dyn_var => 'ep_title',
      :title_regexp => 'proposal\"\,\"[^\"]+\"\,\"[^\"]+\"\,\"([^\"]+)',
      :rationale_dyn_var => 'ep_rationale',
      :rationale_regexp => 'rationale\"\,\"([^\"]+)',
      :modify_fields => {
        :course_information => {},
        :governance => {},
        :course_logistics => {},
        :learning_objectives => {},
        :active_dates => {},
        :financials => {}
      }
    }
    
    opts = defaults.merge(opts)
  
    # Search for proposal
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|13|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Integer/3438268394|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|proposal.queryParam.proposalOptionalName|#{proposal_name}|proposal.search.generic|proposal.resultColumn.proposalOptionalName|1|2|3|4|1|5|5|6|10|7|0|8|1|9|10|0|11|12|13|0|6|0|"
      },
      {
        :dyn_variables => [
          {"name" => opts[:proposal_id_dyn_var], "re" => opts[:proposal_id_regexp]}
        ]
      }
    )
    
    # Select
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|526F889935910B01B2508B535A13901E|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|isAuthorized|org.kuali.student.core.rice.authorization.PermissionType/259370389|java.util.Map|java.util.HashMap/962170901|java.lang.String/2004016611|kualiStudentObjectWorkflowId|%%_#{opts[:proposal_id_dyn_var]}%%|1|2|3|4|2|5|6|5|1|7|1|8|9|8|10|"
      },
      {
        'subst' => 'true'
      }
    )
    
    @request.add_thinktime(2)
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|526F889935910B01B2508B535A13901E|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|getMetadata|java.lang.String/2004016611|kualiStudentObjectWorkflowId|%%_#{opts[:proposal_id_dyn_var]}%%|1|2|3|4|2|5|5|6|7|"
      },{'subst' => 'true'}
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|526F889935910B01B2508B535A13901E|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|getData|java.lang.String/2004016611|%%_#{opts[:proposal_id_dyn_var]}%%|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true',
        :dyn_variables => [
          {"name" => opts[:workflow_id_dyn_var], "re" => opts[:workflow_id_regexp]},
          {"name" => opts[:id_translation_id_dyn_var], "re" => opts[:id_translation_id_regexp]},
          {"name" => opts[:code_dyn_var], "re" => opts[:code_regexp]},
          {"name" => opts[:course_num_suffix_dyn_var], "re" => opts[:course_num_suffix_regexp]},
          {"name" => opts[:lo_category_id_dyn_var], "re" => opts[:lo_category_id_regexp]},
          {"name" => opts[:lo_category_dyn_var], "re" => opts[:lo_category_dyn_var]},
          {"name" => opts[:lo_cat_text_dyn_var], "re" => opts[:lo_cat_text_regexp]},
          {"name" => opts[:lo_cat_id_dyn_var], "re" => opts[:lo_cat_id_regexp]},
          {"name" => opts[:create_id_dyn_var], "re" => opts[:create_id_regexp]},
          {"name" => opts[:course_title_dyn_var], "re" => opts[:course_title_regexp]},
          {"name" => opts[:oversight_org_dyn_var], "re" => opts[:oversight_org_regexp]},
          {"name" => opts[:lab_fee_id_dyn_var], "re" => opts[:lab_fee_id_regexp]},
          {"name" => opts[:atp_dur_week_id_dyn_var], "re" => opts[:atp_dur_week_id_regexp]},
          {"name" => opts[:lab_id_dyn_var], "re" => opts[:lab_id_regexp]},
          {"name" => opts[:grade_id_dyn_var], "re" => opts[:grade_id_regexp]},
          {"name" => opts[:person_id_dyn_var], "re" => opts[:person_id_regexp]},
          {"name" => opts[:joints_dyn_var], "re" => opts[:joints_regexp]},
          {"name" => opts[:subject_area_dyn_var], "re" => opts[:subject_area_regexp]},
          {"name" => opts[:proposal_dyn_var], "re" => opts[:proposal_regexp]},
          {"name" => opts[:proposal_num_dyn_var], "re" => opts[:proposal_num_regexp]},
          {"name" => opts[:title_dyn_var], "re" => opts[:title_regexp]},
          {"name" => opts[:rationale_dyn_var], "re" => opts[:rationale_regexp]}
        ]
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|1|2|3|4|1|5|5|0|0|6|0|7|0|0|0|"
      }
    )
    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|1|2|3|4|1|5|5|0|0|6|0|7|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.percentage|kuali.resultComponent.grade.recitalReview|kuali.resultComponent.grade.designReview|kuali.resultComponent.grade.completedNotation|lrc.search.resultComponent|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|6|11|12|11|13|11|14|11|15|11|16|11|17|0|18|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.percentage|kuali.resultComponent.grade.recitalReview|kuali.resultComponent.grade.designReview|kuali.resultComponent.grade.completedNotation|lrc.search.resultComponent|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|6|11|12|11|13|11|14|11|15|11|16|11|17|0|18|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|enumeration.queryParam.enumerationType|kuali.lu.finalExam.status|enumeration.management.search|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|enumeration.queryParam.enumerationType|kuali.lu.finalExam.status|enumeration.management.search|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|0|0|0|"
      }
    )
    
    @request.add_thinktime(2)
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|D1DD59B8A92305DA33192DAC65F9F820|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflow_id_dyn_var]}%%|1|2|3|4|1|5|6|"
      },{'subst' => 'true'}
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|D1DD59B8A92305DA33192DAC65F9F820|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflow_id_dyn_var]}%%|1|2|3|4|1|5|6|"
      },{'subst' => 'true'}
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|D1DD59B8A92305DA33192DAC65F9F820|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflow_id_dyn_var]}%%|1|2|3|4|1|5|6|"
      },{'subst' => 'true'}
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|D1DD59B8A92305DA33192DAC65F9F820|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflow_id_dyn_var]}%%|1|2|3|4|1|5|6|"
      },{'subst' => 'true'}
    )
    
    
    # Edit Proposal
    
    if(!opts[:modify_fields][:course_information].empty?)
      
      if(opts[:modify_fields][:course_information][:description])
        
        # Save changes
        contents1 = "5|0|159|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|526F889935910B01B2508B535A13901E|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|administeringOrgs|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|58|_runtimeData|id-translation|%%_#{opts[:id_translation_id_dyn_var]}%%|passFail|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|audit|finalExamStatus|STD|campusLocations|ALL|All|code|%%_#{opts[:code_dyn_var]}%%|courseNumberSuffix|%%_#{opts[:course_num_suffix_dyn_var]}%%|courseSpecificLOs|loCategoryInfoList|desc|formatted|&lt;p&gt;Desc&lt;/p&gt;|plain|Desc|effectiveDate|org.kuali.student.core.assembly.data.Data$DateValue/3833457837|java.sql.Timestamp/1769758459|expirationDate|id|%%_#{opts[:lo_category_id_dyn_var]}%%|loRepository|kuali.loRepository.key.singleUse|metaInfo|versionInd|1|name|%%_#{opts[:lo_category_dyn_var]}%%|state|active|type|loCategoryType.subject|loDisplayInfoList|loInfo|sequence|0|%%_#{opts[:lo_cat_text_dyn_var]}%%|%%_#{opts[:lo_cat_id_dyn_var]}%%|loRepositoryKey|createId|%%_#{opts[:create_id_dyn_var]}%%|createTime|updateId|updateTime|SINGLE USE LO|kuali.lo.type.singleUse|courseTitle|%%_#{opts[:course_title_dyn_var]}%%|creditOptions|fixedCreditValue|10|kuali.creditType.credit.degree.10|resultValues|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|curriculumOversightOrgs|51|%%_#{opts[:oversight_org_dyn_var]}%%|descr|#{opts[:modify_fields][:course_information][:description]}|dirty|duration|atpDurationTypeKey|kuali.atp.duration.Year|timeQuantity|org.kuali.student.core.assembly.data.Data$IntegerValue/991919491|Year|expenditure|affiliatedOrgs|feeJustification|fees|feeAmounts|currencyQuantity|currencyTypeKey|kuali.currency.type.usdollars.cents|feeType|kuali.enum.type.feeTypes.labFee|%%_#{opts[:lab_fee_id_dyn_var]}%%|rateType|fixedRateFee|Fixed Rate Fee|Laboratory Fee|formats|activities|activityType|kuali.lu.type.activity.Lab|contactHours|unitQuantity|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_dur_week_id_dyn_var]}%%|2|draft|Lab|%%_#{opts[:lab_id_dyn_var]}%%|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:grade_id_dyn_var]}%%|instructors|personId|%%_#{opts[:person_id_dyn_var]}%%|joints|%%_#{opts[:joints_dyn_var]}%%|pilotCourse|revenues|specialTopicsCourse|subjectArea|%%_#{opts[:subject_area_dyn_var]}%%|termsOffered|kuali.atp.season.Any|Any|kuali.lu.type.CreditCourse|variations|Standard final Exam|transcriptTitle|proposal|%%_#{opts[:proposal_id_dyn_var]}%%|%%_#{opts[:proposal_num_dyn_var]}%%|%%_#{opts[:title_dyn_var]}%%|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|%%_#{opts[:rationale_dyn_var]}%%|kuali.proposal.type.course.create|workflowId|%%_#{opts[:workflow_id_dyn_var]}%%|"
        contents2 = "|1|2|3|4|1|5|5|6|7|0|34|8|9|10|5|6|7|0|2|11|12|0|13|14|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|17|-12|-14|-5|-10|-1|-3|8|18|19|20|0|8|21|19|-22|8|22|13|23|8|24|10|5|6|7|0|2|11|-8|13|25|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|26|-35|-37|-29|-33|-1|-27|8|27|13|28|8|29|13|30|8|31|10|5|6|7|0|1|11|-8|10|5|6|7|0|3|8|32|10|5|6|7|0|1|11|-8|10|5|6|7|0|9|8|33|10|5|6|7|0|2|8|34|13|35|8|36|13|37|-61|-63|8|38|39|40|867724416|1198295875584|0|8|41|39|40|3896582272|1258425417728|0|8|42|13|43|8|44|13|45|8|46|10|5|6|7|0|1|8|47|13|48|-61|-81|8|49|13|50|8|51|13|52|8|53|13|54|-57|-59|-53|-55|8|55|10|5|6|7|0|0|-53|-93|8|56|10|5|6|7|0|7|8|57|13|58|8|33|10|5|6|7|0|2|8|34|13|59|8|36|13|59|-99|-103|8|42|13|60|8|61|13|45|8|46|10|5|6|7|0|5|8|62|13|63|8|64|39|40|3246181412|1284195221504|916000000|8|65|13|63|8|66|39|40|3246183944|1284195221504|448000000|8|47|13|48|-99|-115|8|49|13|67|8|53|13|68|-53|-97|-49|-51|-1|-47|8|69|13|70|8|71|10|5|6|7|0|1|11|-8|10|5|6|7|0|6|8|72|13|73|8|42|13|74|8|46|10|5|6|7|0|1|8|47|13|58|-143|-149|8|75|10|5|6|7|0|1|11|-8|13|73|-143|-155|8|53|13|76|8|15|10|5|6|7|0|1|8|53|10|5|6|7|0|1|8|16|13|77|-165|-167|-143|-163|-139|-141|-1|-137|8|78|10|5|6|7|0|0|-1|-173|8|79|10|5|6|7|0|2|11|-8|13|80|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|81|-185|-187|-179|-183|-1|-177|8|82|10|5|6|7|0|2|8|36|13|83|8|15|10|5|6|7|0|1|8|84|10|5|6|7|0|1|8|36|19|20|1|-201|-203|-195|-199|-1|-193|8|85|10|5|6|7|0|3|8|86|13|87|8|88|89|12|1|8|15|10|5|6|7|0|1|8|86|10|5|6|7|0|1|8|16|13|90|-221|-223|-212|-219|-1|-210|8|91|10|5|6|7|0|1|8|92|10|5|6|7|0|0|-231|-233|-1|-229|8|93|10|5|6|7|0|0|-1|-237|8|94|10|5|6|7|0|1|11|-8|10|5|6|7|0|5|8|95|10|5|6|7|0|1|11|-8|10|5|6|7|0|2|8|96|89|12|10|8|97|13|98|-251|-253|-247|-249|8|99|13|100|8|42|13|101|8|102|13|103|8|15|10|5|6|7|0|2|8|102|10|5|6|7|0|1|8|16|13|104|-270|-272|8|99|10|5|6|7|0|1|8|16|13|105|-270|-278|-247|-268|-243|-245|-1|-241|8|106|10|5|6|7|0|1|11|-8|10|5|6|7|0|5|8|107|10|5|6|7|0|1|11|-8|10|5|6|7|0|9|8|108|13|109|8|110|10|5|6|7|0|3|8|111|13|73|8|112|13|113|8|15|10|5|6|7|0|1|8|112|10|5|6|7|0|1|8|16|13|114|-312|-314|-304|-310|-298|-302|8|79|10|5|6|7|0|0|-298|-320|8|115|89|12|100|8|85|10|5|6|7|0|3|8|86|13|116|8|88|89|12|12|8|15|10|5|6|7|0|1|8|86|10|5|6|7|0|1|8|16|13|117|-338|-340|-329|-336|-298|-327|8|42|13|118|8|46|10|5|6|7|0|5|8|62|13|63|8|64|39|40|3246177449|1284195221504|953000000|8|65|13|63|8|66|39|40|3246183904|1284195221504|408000000|8|47|13|119|-298|-348|8|51|13|120|8|15|10|5|6|7|0|1|8|108|10|5|6|7|0|1|8|16|13|121|-368|-370|-298|-366|-294|-296|-290|-292|8|42|13|122|8|46|10|5|6|7|0|5|8|62|13|63|8|64|39|40|3246177416|1284195221504|920000000|8|65|13|63|8|66|39|40|3246183890|1284195221504|394000000|8|47|13|119|-290|-378|8|51|13|120|8|53|13|123|-286|-288|-1|-284|8|124|10|5|6|7|0|2|11|-8|13|125|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|126|-406|-408|-400|-404|-1|-398|8|42|13|127|8|128|10|5|6|7|0|1|11|-8|10|5|6|7|0|2|8|129|13|63|8|15|10|5|6|7|0|1|8|129|10|5|6|7|0|1|8|16|13|130|-428|-430|-422|-426|-418|-420|-1|8|128|8|131|10|5|6|7|0|0|-1|-437|8|46|10|5|6|7|0|5|8|62|13|63|8|64|39|40|3246166611|1284195221504|115000000|8|65|13|63|8|66|39|40|3246183834|1284195221504|338000000|8|47|13|132|-1|-441|8|133|19|-22|8|134|10|5|6|7|0|0|-1|-459|8|135|19|-22|8|51|13|120|8|136|13|137|8|138|10|5|6|7|0|2|11|-8|13|139|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|140|-477|-479|-471|-475|-1|-469|8|53|13|141|8|142|10|5|6|7|0|0|-1|-487|8|15|10|5|6|7|0|3|8|136|10|5|6|7|0|1|8|16|13|137|-493|-495|8|22|10|5|6|7|0|1|8|16|13|143|-493|-501|-203|10|5|6|7|0|3|8|144|19|-209|8|128|19|-209|8|136|19|-209|-493|-203|-1|-491|8|145|10|5|6|7|0|10|8|42|13|146|8|46|10|5|6|7|0|5|8|62|13|63|8|64|39|40|3246166532|1284195221504|36000000|8|65|13|63|8|66|39|40|3246183375|1284195221504|879000000|8|47|13|147|-518|-522|8|49|13|148|8|149|10|5|6|7|0|1|11|-8|13|127|-518|-540|8|150|13|151|8|152|10|5|6|7|0|0|-518|-548|8|153|10|5|6|7|0|0|-518|-552|8|154|13|155|8|53|13|156|8|157|13|158|-1|-516|-510|13|159|0|0|"
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "#{contents1}#{contents2}"
          },
          {
            'subst' => 'true'
          }
        )
        
      end
      
    end
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|D1DD59B8A92305DA33192DAC65F9F820|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflow_id_dyn_var]}%%|1|2|3|4|1|5|6|"
      },{'subst' => 'true'}
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|D1DD59B8A92305DA33192DAC65F9F820|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflow_id_dyn_var]}%%|1|2|3|4|1|5|6|"
      },{'subst' => 'true'}
    )
    
  
  end
  
  
  # Find Course or Proposal
  def find(type, course_code, course_name,  opts={})
    
    defaults = {
      :nav_homepage => true,
      :find_person => '%%_username%%', #user is the dynvar from users.csv
      :course_description => '',
      :course_number => '',
      :course_name_dyn_var => 'course_name_dyn_var',
      :course_name_var_regexp => '\"([^\"]+)\"\,\"[^\"]+\"\,\"' + course_name + '\"'
#NOTE: The previous regexp returns the text of the word that is 2 words behind the coures name in the comma delimitted http response. NOTE: The quotation marks surrounding the text are stripped.      
# This word is then included in 2 HTTP Requests that are sent later.
    }

    opts = defaults.merge(opts)
  
    # Navigate to Curriculum Mgmt
    self.homepage() unless(!opts[:nav_homepage])
    
    @request.add_thinktime(3)

    # Enter Course Code BSCI and click Search
    # Search Criteria
    if(type == "proposal")
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|13|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|proposal.queryParam.proposalOptionalName|#{course_code}|proposal.search.generic|proposal.resultColumn.proposalOptionalName|1|2|3|4|1|5|6|0|7|0|8|1|9|10|0|11|12|13|0|0|"
        }
      )
    elsif(type == "course")
      # Only searching by title/name
      if(course_code.empty?)
        contents =  "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.lang.Integer/3438268394|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.queryParam.luOptionalState|java.lang.String/2004016611|Approved|Active|Retired|lu.search.mostCurrent.union|lu.resultColumn.luOptionalCode|1|2|3|4|1|5|5|6|10|7|0|8|2|9|10|0|11|9|12|8|3|13|14|13|15|13|16|0|17|18|0|6|0|"
      else
        contents =  "5|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.lang.Integer/3438268394|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalCode|#{course_code}|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.queryParam.luOptionalState|java.lang.String/2004016611|Approved|Active|Retired|lu.search.mostCurrent.union|lu.resultColumn.luOptionalCode|1|2|3|4|1|5|5|6|10|7|0|8|3|9|10|0|11|9|12|0|13|9|14|8|3|15|16|15|17|15|18|0|19|20|0|6|0|"
      end
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => contents
        },
        {
          :dyn_variables => [
            {"name" => opts[:course_name_dyn_var], "re" => opts[:course_name_var_regexp]}
          ]
        }
      )

      @request.add_thinktime(3)
      
      # Click on Name=Insects - Code=BSCI 120 and click Select
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getMetadata|java.lang.String/2004016611|java.util.Map||1|2|3|4|2|5|6|7|0|"
        }
      )
     
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
        }
      )

    # DUPE      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
        }
      )

    # DUPE       
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
        }
      )
      
    # DUPE 
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
        }
      )
      
    # DUPE       
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
        }
      )
        
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
        }
      )
        
    # DUPE       
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
        }
      )

    # DUPE       
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getData|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|1|2|3|4|1|5|6|"
        },{'subst' => 'true'}
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|isLatestVersion|java.lang.String/2004016611|java.lang.Long/4227064769|a359cb8b-508d-41e2-a32b-64a50456e8be|1|2|3|4|2|5|6|7|6|1|0|"
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
        }
      )
        
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:find_person]}|cluModifyItem|1|2|3|4|2|5|5|6|7|"
        }, {'subst' => 'true'}
        )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
        {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
        },{'subst' => 'true'}
      )

      @request.add_thinktime(3)
      
      #Click Detailed View tab -- NOTE: no HTTP Request is sent

      @request.add_thinktime(15)

    end
    
  end
  
  # Browse and View Program with Requisites
  def browse(program_name, program_specialization, requisite1, requisite2,  opts={})
    
    defaults = {
      :nav_homepage => true,
      :browse_person => '%%_username%%', #user is the dynvar from users.csv
      :program_name_dyn_var => 'program_name_dyn_var',
      #NOTE: The following regexp returns the Program. NOTE: This regular expression will only work for the undergraduate Biological Sciences Program that has a Degree Type of Bachelor Science.
      # Due to the fact of duplicate programs of the same name; e.g.,Biological Sciences with a Degree Type of Bachelor of Science and Biological Sciences with a Degree Type of 
      # Doctor of Philosophy exist, a regular expression would have to be created to handle the programs that share the same Program Title; i.e., Biological Sciences
      :program_name_var_regexp => '(REFERENCEPROG-[^\"]+)\"\,\"[^\"]+\"\,\"' + program_specialization + '\"',
      :reqref1_name_dyn_var => 'reqref1_name_dyn_var',
      #NOTE: The following regular expression will only work if requisite1 is BSCI106 in the "Transfer Student Entry" section. There is also a BSCI106 in the Basic Program section.
      # Also, if it is a different course, the HTTP response must be viewed to help create the regular expression.
      :reqref1_name_var_regexp => requisite1 + '\"\,\"[^\"]+\"\,\"([^\"]+)',
      :reqref2_name_dyn_var => 'reqref2_name_dyn_var',
      #NOTE: The following regular expression will only work if requisite2 is BSCI222 in the "Basic Program" section.
      # Also, if it is a different course, the HTTP response must be viewed to help create the regular expression.      
      :reqref2_name_var_regexp => requisite2 + '\"\,\"[^\"]+\"\,\"([^\"]+)'
    }

    opts = defaults.merge(opts)

    # Navigate to Curriculum Mgmt
    self.homepage() unless(!opts[:nav_homepage])

    @request.add_thinktime(3)
    
    # The next 7 HTTP Requests happen after clicking Browse Academic Programs
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/MetadataRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C721122BF64327C2BB379CD5224A091|org.kuali.student.common.ui.client.service.MetadataRpcService|getMetadata|java.lang.String/2004016611|browseProgram|1|2|3|4|3|5|5|5|6|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|lu.search.browseProgram|1|2|3|4|1|5|5|0|6|0|7|0|8|0|0|0|"
      },
      {
        :dyn_variables => [
          {"name" => opts[:program_name_dyn_var], "re" => opts[:program_name_var_regexp]}
        ]
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|15|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.enum.lu.program.level|enumeration.queryParam.enumerationCode|java.lang.String/2004016611|kuali.lu.program.level.UnderGraduate|kuali.lu.program.level.Graduate|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|2|11|12|11|13|0|14|15|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.degree|lrc.search.resultComponent|lrc.resultColumn.resultComponent.name|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalState|java.lang.String/2004016611|Active|lu.queryParam.luOptionalType|kuali.lu.type.credential.Baccalaureate|kuali.lu.type.credential.Masters|kuali.lu.type.credential.Professional|kuali.lu.type.credential.Doctoral|kuali.lu.type.credential.UndergraduateCertificate|kuali.lu.type.credential.GraduateCertificate |kuali.lu.type.credential.ContinuingEd|lu.search.generic|lu.resultColumn.luOptionalLongName|1|2|3|4|1|5|5|0|0|6|2|7|8|6|1|9|10|0|7|11|6|7|9|12|9|13|9|14|9|15|9|16|9|17|9|18|0|19|20|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.state|enumeration.queryParam.enumerationCode|java.lang.String/2004016611|Active|Retired|Suspended|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|3|11|12|11|13|11|14|0|15|16|0|0|"
      }
    )

    @request.add_thinktime(3)
    
    # The next 23 HTTP Requests happen after clicking on the Undergraduate check box and then clicking on Biological Sciences and then clicking Select
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/majorDisciplineRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|2CB883AE47B1ED601F45C2FB3FF135F5|org.kuali.student.lum.program.client.rpc.MajorDisciplineRpcService|getData|java.lang.String/2004016611|%%_#{opts[:program_name_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/majorDisciplineRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|2CB883AE47B1ED601F45C2FB3FF135F5|org.kuali.student.lum.program.client.rpc.MajorDisciplineRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|%%_#{opts[:program_name_dyn_var]}%%|java.util.HashMap/962170901|ID_TYPE|objectId|DtoState|Active|DtoNextState|Superseded|1|2|3|4|2|5|6|7|8|3|5|9|5|10|5|11|5|12|5|13|5|14|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|13|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.publicationType.idRestrictionList|java.lang.String/2004016611|kuali.lu.publication.GradCatalog|kuali.lu.publication.UndergradCatalog|lu.search.publication.types|lu.resultColumn.publicationType.id|1|2|3|4|1|5|5|0|0|6|1|7|8|6|2|9|10|9|11|0|12|13|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|13|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.publicationType.idRestrictionList|java.lang.String/2004016611|kuali.lu.publication.GradCatalog|kuali.lu.publication.UndergradCatalog|lu.search.publication.types|lu.resultColumn.publicationType.id|1|2|3|4|1|5|5|0|0|6|1|7|8|6|2|9|10|9|11|0|12|13|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CommentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|62D53D0C5087061126A72510E98E7E9A|org.kuali.student.core.comments.ui.client.service.CommentRpcService|getUserRealName|java.lang.String/2004016611|#{opts[:browse_person]}|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/majorDisciplineRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|2CB883AE47B1ED601F45C2FB3FF135F5|org.kuali.student.lum.program.client.rpc.MajorDisciplineRpcService|isLatestVersion|java.lang.String/2004016611|java.lang.Long/4227064769|1e42e6db-e7e2-4d77-9feb-c3a5ed4233ab|1|2|3|4|2|5|6|7|6|1|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementType|java.lang.String/2004016611|kuali.statement.type.program|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/majorDisciplineRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|2CB883AE47B1ED601F45C2FB3FF135F5|org.kuali.student.lum.program.client.rpc.MajorDisciplineRpcService|getProgramRequirements|java.util.List|java.util.ArrayList/3821976829|java.lang.String/2004016611|96bbb8bd-a208-44c3-bd27-64d4acdcd059|c569c214-fd1e-4c4f-a107-2e3d0cea2aec|0c1e0815-cc7b-4f88-825b-3ea1e147e80e|7c3248e1-a612-462a-bdb1-541e98e06ff5|dbcae369-5fa0-4a91-880c-649326be58d4|1|2|3|4|1|5|6|5|7|8|7|9|7|10|7|11|7|12|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|aaa2ea4b-32d2-4ddf-94ed-7a87a5af0339|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|f72e672b-18e4-47bc-b786-706acb11a6b0|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|02416a8c-3bb4-4215-a3dd-3e1c7ca287d9|1|2|3|4|1|5|6|"
      },
      {
        :dyn_variables => [
          {"name" => opts[:reqref1_name_dyn_var], "re" => opts[:reqref1_name_var_regexp]}
        ]
      },
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|2bf26abe-57ab-4b87-888e-861536e3574f|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|746a486f-34db-420f-a1f6-3dc58e740f8d|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|29f7168e-0bc6-4752-ae4e-239095ecb1e5|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|0fa575c5-9b7f-44e0-98d5-6bf2e9c431c6|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|034fc2ea-2e2e-4e9d-9196-124bce485d13|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|f23b18dd-8a5e-43ff-b1b1-cd02fc130b91|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|3b15f7da-89f5-4e76-9901-2e26469fd442|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|5a300769-0b48-46c2-86a0-9373557fc8ed|1|2|3|4|1|5|6|"
      },
      {
        :dyn_variables => [
          {"name" => opts[:reqref2_name_dyn_var], "re" => opts[:reqref2_name_var_regexp]}
        ]
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|e19bd5e2-3ee8-4613-8e6c-43b1deda16c0|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|852c43eb-eba8-4151-bd62-4eae39b3bfbf|1|2|3|4|1|5|6|"
      }
    )

    @request.add_thinktime(15)
    
    # The next 15 HTTP Requests happen after clicking on "Program Requirements"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementType|java.lang.String/2004016611|kuali.statement.type.program|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/majorDisciplineRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|2CB883AE47B1ED601F45C2FB3FF135F5|org.kuali.student.lum.program.client.rpc.MajorDisciplineRpcService|getProgramRequirements|java.util.List|java.util.ArrayList/3821976829|java.lang.String/2004016611|96bbb8bd-a208-44c3-bd27-64d4acdcd059|c569c214-fd1e-4c4f-a107-2e3d0cea2aec|0c1e0815-cc7b-4f88-825b-3ea1e147e80e|7c3248e1-a612-462a-bdb1-541e98e06ff5|dbcae369-5fa0-4a91-880c-649326be58d4|1|2|3|4|1|5|6|5|7|8|7|9|7|10|7|11|7|12|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|aaa2ea4b-32d2-4ddf-94ed-7a87a5af0339|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|f72e672b-18e4-47bc-b786-706acb11a6b0|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|02416a8c-3bb4-4215-a3dd-3e1c7ca287d9|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true'
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|2bf26abe-57ab-4b87-888e-861536e3574f|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|746a486f-34db-420f-a1f6-3dc58e740f8d|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|29f7168e-0bc6-4752-ae4e-239095ecb1e5|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|0fa575c5-9b7f-44e0-98d5-6bf2e9c431c6|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|034fc2ea-2e2e-4e9d-9196-124bce485d13|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|f23b18dd-8a5e-43ff-b1b1-cd02fc130b91|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|3b15f7da-89f5-4e76-9901-2e26469fd442|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|5a300769-0b48-46c2-86a0-9373557fc8ed|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|e19bd5e2-3ee8-4613-8e6c-43b1deda16c0|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|852c43eb-eba8-4151-bd62-4eae39b3bfbf|1|2|3|4|1|5|6|"
      }
    )

    @request.add_thinktime(15)
    
    # The next 24 HTTP Requests happen after clicking on "BSCI106 PRIN BIOL II 4.0 Credits"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|getContextPath|1|2|3|4|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|getPrincipalUsername|1|2|3|4|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/MetadataRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C721122BF64327C2BB379CD5224A091|org.kuali.student.common.ui.client.service.MetadataRpcService|getMetadata|java.lang.String/2004016611|search|1|2|3|4|3|5|5|5|6|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|application.url|ks.rice.docSearch.serviceAddress|lum.application.url|ks.rice.url|ks.rice.label|ks.application.version|ks.gwt.codeServer|1|2|3|4|1|5|6|7|7|8|9|10|11|12|13|14|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getMetadata|java.lang.String/2004016611|java.util.Map||1|2|3|4|2|5|6|7|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:browse_person]}|useCurriculumReview|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getData|java.lang.String/2004016611|%%_#{opts[:reqref1_name_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|isLatestVersion|java.lang.String/2004016611|java.lang.Long/4227064769|485712a2-5559-44d5-9c5d-5c765910d5c0|1|2|3|4|2|5|6|7|6|1|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:browse_person]}|cluModifyItem|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:reqref1_name_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(15)
    
    # The next 24 HTTP Requests happen after clicking on "BSCI122 PRIN GENETICS 4.0 Credits" 
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|getContextPath|1|2|3|4|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|getPrincipalUsername|1|2|3|4|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/MetadataRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C721122BF64327C2BB379CD5224A091|org.kuali.student.common.ui.client.service.MetadataRpcService|getMetadata|java.lang.String/2004016611|search|1|2|3|4|3|5|5|5|6|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|application.url|ks.rice.docSearch.serviceAddress|lum.application.url|ks.rice.url|ks.rice.label|ks.application.version|ks.gwt.codeServer|1|2|3|4|1|5|6|7|7|8|9|10|11|12|13|14|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getMetadata|java.lang.String/2004016611|java.util.Map||1|2|3|4|2|5|6|7|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:browse_person]}|useCurriculumReview|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

  # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getData|java.lang.String/2004016611|%%_#{opts[:reqref2_name_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, 
      {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|isLatestVersion|java.lang.String/2004016611|java.lang.Long/4227064769|f7000cfc-3bf3-4fc8-9363-be39978b3758|1|2|3|4|2|5|6|7|6|2|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:browse_person]}|cluModifyItem|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:reqref2_name_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(15)
    
    # The next HTTP Request happens after clicking the "Detailed View" tab
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|6f7421b8-2fe6-4b42-90c8-cbe29dc503be|1|2|3|4|1|5|6|"
      }
    )
      @request.add_thinktime(15)

  end

  # Dependency analysis
  def dependency(coursename,  opts={})
    
    defaults = {
      :dependency_person => '%%_username%%', #user is the dynvar from users.csv
      :item => '222',
      :nav_homepage => true,      
      :item_name_dyn_var => 'item_name_dyn_var',
      #NOTE: The following regexp returns the Program. NOTE: This regular expression will only work for the undergraduate Biological Sciences Program that has a Degree Type of Bachelor Science.
      # Due to the fact of duplicate programs of the same name; e.g.,Biological Sciences with a Degree Type of Bachelor of Science and Biological Sciences with a Degree Type of 
      # Doctor of Philosophy exist, a regular expression would have to be created to handle the programs that share the same Program Title; i.e., Biological Sciences
      :item_name_var_regexp => '([^\"]+)\"\,\"[^\"]+\"\,\"[^\"]+\"\,\"' + coursename
    }

    opts = defaults.merge(opts)

    # Navigate to Curriculum Mgmt
    self.homepage() unless(!opts[:nav_homepage])

    @request.add_thinktime(3)
      
    # The next 4 HTTP Requests happen after clicking the Dependency Analysis button

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/MetadataRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C721122BF64327C2BB379CD5224A091|org.kuali.student.common.ui.client.service.MetadataRpcService|getMetadata|java.lang.String/2004016611|dependency|1|2|3|4|3|5|5|5|6|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.dependency.course.types|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.dependency.program.types|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.dependency.courseSet.types|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )
     
    @request.add_thinktime(3)
    
    # The next HTTP Request happens after clicking the Dependency Analysis button
    # Item
    # AJAX popup while typing in item text box
    for i in 1..opts[:item].length
      itr = i-1
      if(i == opts[:item].length)
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalCode|#{opts[:item][0..itr]}|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.search.mostCurrent.union||1|2|3|4|1|5|5|0|6|0|7|2|8|9|0|10|8|11|0|12|13|14|0|0|"
          },
          {
            :dyn_variables => [
              {"name" => opts[:item_name_dyn_var], "re" => opts[:item_name_var_regexp]}
            ]
          }
        )
      else
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalCode|#{opts[:item][0..itr]}|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.search.mostCurrent.union||1|2|3|4|1|5|5|0|6|0|7|2|8|9|0|10|8|11|0|12|13|14|0|0|"
          }
        )
      end
    end

    @request.add_thinktime(3)
    
    # The next 18 HTTP Requests happen after selecting BSCI122 and clicking Go
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalCluId|%%_#{opts[:item_name_dyn_var]}%%|lu.search.dependencyAnalysis|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|0|0|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|0475e30e-a49b-437c-815e-fced851c372d|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|4fcc5c7e-4bea-49a4-933e-5551bbfaf1e9|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|e153f790-fd4e-484f-8df7-6fc3346cf23c|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|23628512-7b76-4426-8b46-067c0d6ad3cf|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|3f4cec57-cf8c-4aa5-91a9-61888dbb0ebd|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|39582801-3036-43c0-9278-e48f4332a7b9|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|616791d4-1739-46d4-a219-4283da0a2c69|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|18d4f308-7491-41cb-a44d-433b73cc454e|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|9d00060f-f482-4445-a05c-85db0c48a562|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|5eb41297-9db3-41be-8f37-59496d281a13|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|22a37764-7900-4d94-b169-b750192fe952|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|5eed269d-298c-4a30-916e-98d44508af71|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|0da24a86-fae3-47ed-861c-8cfa41b6e2f0|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|501c6d47-9c44-4c6a-abc7-aebba083d3a1|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|9789556c-13b3-4f25-963b-70de685d1860|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DependencyAnalysisRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|6332C2BE1BF400BEE80978F73BF78C01|org.kuali.student.lum.lu.ui.dependency.client.service.DependencyAnalysisRpcService|getRequirementComponentNL|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|7b030316-3398-44aa-9464-ab2db3bbf0af|1|2|3|4|1|5|6|7|1|8|"
      }
    )

    @request.add_thinktime(15)
    
    # The next 18 HTTP Requests happen after clicking the View Course Set button
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|getContextPath|1|2|3|4|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|getPrincipalUsername|1|2|3|4|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/MetadataRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C721122BF64327C2BB379CD5224A091|org.kuali.student.common.ui.client.service.MetadataRpcService|getMetadata|java.lang.String/2004016611|search|1|2|3|4|3|5|5|5|6|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|application.url|ks.rice.docSearch.serviceAddress|lum.application.url|ks.rice.url|ks.rice.label|ks.application.version|ks.gwt.codeServer|1|2|3|4|1|5|6|7|7|8|9|10|11|12|13|14|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|courseSet|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|courseSet|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|courseSet|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|courseSet|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|courseSet|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|courseSet|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|courseSet|1|2|3|4|2|5|6|7|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:dependency_person]}|useCurriculumReview|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|search|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|search|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|search|1|2|3|4|2|5|6|7|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|search|1|2|3|4|2|5|6|7|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getData|java.lang.String/2004016611|1269a3fa-cb27-42ae-a239-7445707b94cd|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getCluSetInformation|java.lang.String/2004016611|1269a3fa-cb27-42ae-a239-7445707b94cd|1|2|3|4|1|5|6|"
      }
    )

    @request.add_thinktime(15)

    # The next HTTP Request happens after clicking "Export Summary to File" button and then clicking the "Export" button
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/GwtExportRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|38|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|65DEC1FAFBA453825B5B95A0C63006C1|org.kuali.student.common.ui.client.service.GwtExportRpcService|reportExport|java.util.List|org.kuali.student.common.assembly.data.Data/3184510345|java.lang.String/2004016611|java.util.ArrayList/3821976829|org.kuali.student.common.ui.client.util.ExportElement/3779793473|BSCI222 - Principles of Genetics||Dependency Analysis|Course Dependencies|<b>BSCI222</b> is a/an <b>Student Eligibility + Prerequisite</b> for the following course(16):|BSCI360 - Principles of Animal Behavior|BSCI380 - Bioinformatics and Integrated Genomics|BSCI410 - Molecular Genetics|BSCI412 - Microbial Genetics|BSCI414 - Recombinant DNA Laboratory|BSCI416 - Biology of the Human Genome|BSCI417 - Microbial Pathogenesis|BSCI420 - Cell Biology Lectures|BSCI421 - Cell Biology|BSCI422 - Principles of Immunology|BSCI423 - Immunology Laboratory|BSCI430 - Developmental Biology|BSCI433 - Biology of Cancer|BSCI437 - General Virology|BSCI465 - Behavioral Ecology|BSCI471 - Molecular Evolution|Program Dependencies|<b>BSCI222</b> is a/an <b>Completion Requirements</b> for the following program(1):|BSCI - Biological Sciences |Course Set Inclusions|<b>BSCI222</b> is a/an <b>Course Set</b> for the following courseSet(1):|BSOS Supporting Sequence Lower-level Courses|analysis.template|PDF|1|2|3|4|5|5|6|7|7|7|8|11|9|0|10|0|0|1|11|0|12|9|0|11|0|0|-1|11|0|12|9|0|13|0|0|1|11|0|12|9|0|14|0|0|2|11|8|16|9|0|15|0|0|4|11|0|12|9|0|16|0|0|4|11|0|12|9|0|17|0|0|4|11|0|12|9|0|18|0|0|4|11|0|12|9|0|19|0|0|4|11|0|12|9|0|20|0|0|4|11|0|12|9|0|21|0|0|4|11|0|12|9|0|22|0|0|4|11|0|12|9|0|23|0|0|4|11|0|12|9|0|24|0|0|4|11|0|12|9|0|25|0|0|4|11|0|12|9|0|26|0|0|4|11|0|12|9|0|27|0|0|4|11|0|12|9|0|28|0|0|4|11|0|12|9|0|29|0|0|4|11|0|12|9|0|30|0|0|4|11|0|12|12|9|0|11|0|0|-1|11|0|12|9|0|31|0|0|1|11|0|12|9|0|32|0|0|2|11|8|1|9|0|33|0|0|4|11|0|12|12|9|0|11|0|0|-1|11|0|12|9|0|34|0|0|1|11|0|12|9|0|35|0|0|2|11|8|1|9|0|36|0|0|4|11|0|12|12|9|0|11|0|0|-1|11|0|12|0|37|38|12|"
      }
    )

    @request.add_thinktime(15)
         
    # NOTE: There is not an HTTP Request sent after clicking "OK" with the "Open with 'Preview (default)" radio button selected

  end

  # Propose Course Modification
  def propose_course_modification(course_title, course_name, course_number, new_course_title, new_description_addition, new_proposal_rationale, new_credit_value,  opts={})

    defaults = {
      :modification_person => '%%_username%%', #user is the dynvar from users.csv
      :course_code => "BSCI",
      :nav_homepage => true,      
      :course_name_dyn_var => 'course_name_dyn_var',
      :course_name_var_regexp => '([^\"]+)\"\,\"[^\"]+\"\,\"[^\"]+\"\,\"[^\"]+\"\,\"' + course_name,
      :course_ind_dyn_var => 'course_ind_dyn_var',
      :course_ind_var_regexp => 'versionIndId\"\,\"([^\"]+)',
      :pass_fail_dyn_var => 'pass_fail_dyn_var',
      :pass_fail_var_regexp => 'Pass-Fail\"\,\"([^\"]+)',
      :description_dyn_var => 'description_dyn_var',
      :description_var_regexp => '\"descr\"\,\"formatted\"\,\"([^\"]+)',
      :new_credit_id_dyn_var => 'new_credit_dyn_var',
      :new_credit_id_var_regexp => '\"fixedCreditValue\"\,\"[^\"]+\"\,\"[^\"]+\"\,\"([^\"]+)',
      :defaultEnrollmentEstimate_dyn_var => 'defaultEnrollmentEstimate_dyn_var',
      :defaultEnrollmentEstimate_var_regexp => 'defaultEnrollmentEstimate\"\,\"([^\"]+)',
      :lecture_dyn_var => 'lecture_dyn_var',
      :lecture_var_regexp => '\"Lecture\"\,\"([^\"]+)',
      :preRoute_dyn_var => 'preRoute_dyn_var',
      :preRoute_var_regexp => 'PreRoute\"\,\"([^\"]+)',
      :workflowId_dyn_var => 'workflowId_dyn_var',
      :workflowId_var_regexp => 'workflowId\"\,\"([^\"]+)',
      :new_active_date_dyn_var => 'new_active_date_dyn_var',
      :new_active_date_var_regexp => '([^\"]+)\"\,\"Standard final Exam'
      # :course_name_var_regexp => '\"([^\"]+)\"\,\"[^\"]+\"\,\"' + course_name + '\"'
      #NOTE: The previous regexp returns the text of the word that is 2 words behind the coures name in the comma delimitted http response. NOTE: The quotation marks surrounding the text are stripped.      
      # This word is then included in 2 HTTP Requests that are sent later.
    }
    
    opts = defaults.merge(opts)
  
    # Navigate to Curriculum Mgmt
    self.homepage() unless(!opts[:nav_homepage])

    # Enter Course Title insects and click Search

    # The next 20 HTTP Requests find BSCI120
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.lang.Integer/3438268394|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalLongName|#{course_title}|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.queryParam.luOptionalState|java.lang.String/2004016611|Approved|Active|Retired|lu.search.mostCurrent.union|lu.resultColumn.luOptionalCode|1|2|3|4|1|5|5|6|10|7|0|8|3|9|10|0|11|9|12|0|13|9|14|8|3|15|16|15|17|15|18|0|19|20|0|6|0|"
      },
      {
        :dyn_variables => [
          {"name" => opts[:course_name_dyn_var], "re" => opts[:course_name_var_regexp]}
        ]
      }
    )
      
    # Click on Name=Insects - Code=BSCI120 and click Select
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getMetadata|java.lang.String/2004016611|java.util.Map||1|2|3|4|2|5|6|7|0|"
      }
    )
     
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6||"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # DUPE      
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )
      
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    # DUPE       
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )
      
    # DUPE 
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )
      
    # DUPE       
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )
        
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    # DUPE       
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    # DUPE       
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getData|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|1|2|3|4|1|5|6|"
      },{'subst' => 'true',
          :dyn_variables => [
          {"name" => opts[:course_ind_dyn_var], "re" => opts[:course_ind_var_regexp]}
        ]
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|isLatestVersion|java.lang.String/2004016611|java.lang.Long/4227064769|%%_#{opts[:course_ind_dyn_var]}%%|1|2|3|4|2|5|6|7|6|1|0|"
      },{'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )
        
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:modification_person]}|cluModifyItem|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      },{'subst' => 'true'}
    )

    @request.add_thinktime(3)

    # The next 41 HTTP Requests happen after clicking "Propose Course Modification" in the Course Actions dropdown list
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:modification_person]}|cluModifyItem|1|2|3|4|2|5|5|6|7|"
      },{'subst' => 'true'}
    )    

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|isLatestVersion|java.lang.String/2004016611|java.lang.Long/4227064769|%%_#{opts[:course_ind_dyn_var]}%%|1|2|3|4|2|5|6|7|6|1|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|isAuthorized|org.kuali.student.common.rice.authorization.PermissionType/1943437355|java.util.Map|java.util.HashMap/962170901|java.lang.String/2004016611|copyOfObjectId|%%_#{opts[:course_ind_dyn_var]}%%|1|2|3|4|2|5|6|5|0|7|1|8|9|8|10|"
      }, {'subst' => 'true'}
    )
 
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|17|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|proposal|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|type|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|kuali.proposal.type.course.modify|versionInfo|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionComment|1|2|3|4|1|5|5|6|7|0|2|8|9|10|5|6|7|0|1|8|11|12|13|-1|-3|8|14|10|5|6|7|0|2|8|15|12|16|8|17|12|17|-1|-9|0|0|"
      }, {'subst' => 'true',
          :dyn_variables => [
          {"name" => opts[:pass_fail_dyn_var], "re" => opts[:pass_fail_var_regexp]},
          {"name" => opts[:description_dyn_var], "re" => opts[:description_var_regexp]},
          {"name" => opts[:defaultEnrollmentEstimate_dyn_var], "re" => opts[:defaultEnrollmentEstimate_var_regexp]},
          {"name" => opts[:lecture_dyn_var], "re" => opts[:lecture_var_regexp]},
          {"name" => opts[:preRoute_dyn_var], "re" => opts[:preRoute_var_regexp]},
          {"name" => opts[:workflowId_dyn_var], "re" => opts[:workflowId_var_regexp]}
        ]
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getData|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:pass_fail_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|%%_#{opts[:preRoute_dyn_var]}%%|java.util.HashMap/962170901|ID_TYPE|kualiStudentObjectWorkflowId|documentTypeName|kuali.proposal.type.course.modify|DtoState|Draft|DtoNextState||DtoWorkflowNode|PreRoute|1|2|3|4|2|5|6|7|8|5|5|9|5|10|5|11|5|12|5|13|5|14|5|15|5|16|5|17|5|18|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpDurationTypes|atp.resultColumn.atpDurTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.finalExam.status|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponentType.credit.degree.fixed|kuali.resultComponentType.credit.degree.range|kuali.resultComponentType.credit.degree.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|1|7|8|6|3|9|10|9|11|9|12|0|13|14|0|0|"
      }
    )

    # DUPE  
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponentType.credit.degree.fixed|kuali.resultComponentType.credit.degree.range|kuali.resultComponentType.credit.degree.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|1|7|8|6|3|9|10|9|11|9|12|0|13|14|0|0|"
      }
    )

    # DUPE  
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponentType.credit.degree.fixed|kuali.resultComponentType.credit.degree.range|kuali.resultComponentType.credit.degree.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|1|7|8|6|3|9|10|9|11|9|12|0|13|14|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # DUPE 
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # DUPE 
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # DUPE 
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CommentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|62D53D0C5087061126A72510E98E7E9A|org.kuali.student.core.comments.ui.client.service.CommentRpcService|getUserRealName|java.lang.String/2004016611|#{opts[:modification_person]}|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|22|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2007-2008|atp.advancedAtpSearchParam.atpEndDateAtpConstraintIdExclusive|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|org.kuali.student.common.search.dto.SortDirection/1734387768|1|2|3|4|1|5|5|0|0|6|3|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|7|19|0|0|20|21|22|1|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5771428875B68D3E8EC7527EC8D18D40|org.kuali.student.core.document.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:preRoute_dyn_var]}%%|1|2|3|4|2|5|5|6|7|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|subjectCode.queryParam.code||subjectCode.search.orgsForSubjectCode|subjectCode.resultColumn.orgLongName|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintIdExclusive|kuali.atp.FA2007-2008|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|6|2|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|19|20|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|22|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2007-2008|atp.advancedAtpSearchParam.atpEndDateAtpConstraintIdExclusive|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|org.kuali.student.common.search.dto.SortDirection/1734387768|1|2|3|4|1|5|5|0|0|6|3|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|7|19|0|0|20|21|22|1|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|19|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|6|2|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|0|18|19|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|145|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|validate|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|120|courseSpecificLOs|courseTitle|Insects|creditOptions|fixedCreditValue|3.0|id|kuali.creditType.credit.degree.3.0|metaInfo|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateTime|versionInd|0|resultValues|state|Active|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|formatted|A survey of the major groups of insects, their natural history, and their relationships with humans and their environment. Course not acceptable toward major requirements in the College of Chemical and Life Sciences.|plain|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|createId|#{opts[:modification_person]}|java.util.Date/1659716317|updateId|Draft|unitsContentOwner|Lecture|%%_#{opts[:lecture_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|Letter|Pass-Fail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|1|outOfClassHours|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{opts[:course_code]}|kuali.atp.season.Winter|kuali.atp.season.Fall|kuali.atp.season.Spring|Winter|Fall|Spring|transcriptTitle|INSECTS|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|Standard final Exam|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|2|name|Modify: Insects|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|collaboratorInfo|collaborators|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|3|8|37|38|39|3529482200|1288490188800|0|8|40|38|39|3529482200|1288490188800|0|8|41|14|42|-43|-49|8|43|17|5|6|7|0|1|18|-15|14|33|-43|-61|8|44|14|45|8|46|14|47|8|21|17|5|6|7|0|1|8|46|17|5|6|7|0|1|8|22|14|48|-73|-75|-43|-71|-39|-41|-1|-37|8|49|17|5|6|7|0|0|-1|-81|8|50|17|5|6|7|0|2|8|51|14|52|8|53|14|52|-1|-85|8|54|17|5|6|7|0|3|8|55|14|56|8|57|58|19|1|8|21|17|5|6|7|0|1|8|55|17|5|6|7|0|1|8|22|14|59|-104|-106|-95|-102|-1|-93|8|60|38|39|3208226304|1185410973696|0|8|61|17|5|6|7|0|1|8|62|17|5|6|7|0|0|-117|-119|-1|-115|8|63|17|5|6|7|0|0|-1|-123|8|64|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|65|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|66|14|67|8|68|17|5|6|7|0|3|8|69|14|70|8|71|14|72|8|21|17|5|6|7|0|1|8|71|17|5|6|7|0|1|8|22|14|73|-155|-157|-147|-153|-141|-145|8|74|58|-15|8|54|17|5|6|7|0|3|8|55|14|56|8|57|58|-101|8|21|17|5|6|7|0|1|8|55|17|5|6|7|0|1|8|22|14|59|-175|-177|-167|-173|-141|-165|8|34|14|75|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|437634517|1322849927168|8|79|14|77|8|40|38|78|437634517|1322849927168|8|41|14|42|-141|-185|8|44|14|80|8|81|17|5|6|7|0|0|-141|-203|8|21|17|5|6|7|0|1|8|66|17|5|6|7|0|1|8|22|14|82|-209|-211|-141|-207|-137|-139|-133|-135|8|34|14|83|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|437634515|1322849927168|8|79|14|77|8|40|38|78|437634515|1322849927168|8|41|14|42|-133|-219|8|44|14|80|8|84|17|5|6|7|0|0|-133|-237|8|46|14|85|-129|-131|-1|-127|8|86|17|5|6|7|0|3|18|-15|14|87|18|-101|14|88|8|21|17|5|6|7|0|2|18|-15|17|5|6|7|0|1|8|22|14|89|-253|-255|18|-101|17|5|6|7|0|1|8|22|14|90|-253|-261|-245|-251|-1|-243|8|34|14|91|8|92|17|5|6|7|0|0|-1|-269|8|93|17|5|6|7|0|0|-1|-273|8|94|14|95|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|437634286|1322849927168|8|79|14|77|8|40|38|78|437634433|1322849927168|8|41|14|96|-1|-279|8|97|17|5|6|7|0|2|8|69|14|96|8|71|14|72|-1|-295|8|98|10|11|0|8|99|17|5|6|7|0|0|-1|-306|8|100|10|-305|8|44|14|80|8|101|14|102|8|84|17|5|6|7|0|4|18|-15|14|103|18|-101|14|104|18|19|2|14|105|8|21|17|5|6|7|0|3|18|-15|17|5|6|7|0|1|8|22|14|106|-329|-331|18|-101|17|5|6|7|0|1|8|22|14|107|-329|-337|18|-325|17|5|6|7|0|1|8|22|14|108|-329|-343|-318|-327|-1|-316|8|109|14|110|8|46|14|111|8|81|17|5|6|7|0|2|18|-15|14|112|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|113|-361|-363|-355|-359|-1|-353|8|114|17|5|6|7|0|0|-1|-369|8|115|17|5|6|7|0|0|-1|-373|8|116|17|5|6|7|0|4|8|117|118|119|2|0|8|120|14|120|8|121|14|122|8|123|14|124|-1|-377|8|21|17|5|6|7|0|2|8|101|17|5|6|7|0|1|8|22|14|102|-392|-394|8|13|17|5|6|7|0|1|8|22|14|125|-392|-400|-1|-390|8|126|17|5|6|7|0|12|8|127|14|128|8|129|14|130|8|34|14|131|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|437634994|1322849927168|8|79|14|77|8|40|38|78|437642482|1322849927168|8|41|14|132|-408|-416|8|133|14|134|8|135|17|5|6|7|0|1|18|-15|14|91|-408|-434|8|136|14|137|8|138|17|5|6|7|0|0|-408|-442|8|139|17|5|6|7|0|0|-408|-446|8|44|14|140|8|46|14|141|8|142|14|143|-1|-406|8|144|17|5|6|7|0|1|8|145|17|5|6|7|0|0|-458|-460|-1|-456|0|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|22|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2007-2008|atp.advancedAtpSearchParam.atpEndDateAtpConstraintIdExclusive|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|org.kuali.student.common.search.dto.SortDirection/1734387768|1|2|3|4|1|5|5|0|0|6|3|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|7|19|0|0|20|21|22|1|0|"
      }
    )

    @request.add_thinktime(10)
     
    # The next HTTP Request happens after clicking "Course Information" in the left-hand pane
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|subjectCode.queryParam.code|#{opts[:course_code]}|subjectCode.search.orgsForSubjectCode|subjectCode.resultColumn.orgLongName|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    ) 

    @request.add_thinktime(10)
    
    # The next 4 HTTP Requests happen after clicking "Save" after modifying Course Information as follows:
    # Change course title to "Insects for fun!"
    # Add "It will be fun! to the end of the description"
    # Enter "because there is not enuff fun" for Proposal Rationale

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|149|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|120|courseSpecificLOs|courseTitle|#{new_course_title}|creditOptions|fixedCreditValue|3.0|id|kuali.creditType.credit.degree.3.0|metaInfo|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateTime|versionInd|0|resultValues|state|Active|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|%%_#{opts[:description_dyn_var]}%%#{new_description_addition}|dirty|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|createId|#{opts[:modification_person]}|java.util.Date/1659716317|updateId|Draft|unitsContentOwner|Lecture|%%_#{opts[:lecture_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|Letter|Pass-Fail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|1|outOfClassHours|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{opts[:course_code]}|kuali.atp.season.Winter|kuali.atp.season.Fall|kuali.atp.season.Spring|Winter|Fall|Spring|transcriptTitle|INSECTS|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|Standard final Exam|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|2|name|Modify: Insects|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|rationale|#{new_proposal_rationale}|collaboratorInfo|collaborators|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|3|8|37|38|39|3529482200|1288490188800|0|8|40|38|39|3529482200|1288490188800|0|8|41|14|42|-43|-49|8|43|17|5|6|7|0|1|18|-15|14|33|-43|-61|8|44|14|45|8|46|14|47|8|21|17|5|6|7|0|1|8|46|17|5|6|7|0|1|8|22|14|48|-73|-75|-43|-71|-39|-41|-1|-37|8|49|17|5|6|7|0|0|-1|-81|8|50|17|5|6|7|0|3|8|51|14|52|8|53|14|54|8|21|17|5|6|7|0|1|8|55|17|5|6|7|0|1|8|53|10|-5|-95|-97|-87|-93|-1|-85|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|19|1|8|21|17|5|6|7|0|1|8|57|17|5|6|7|0|1|8|22|14|61|-114|-116|-105|-112|-1|-103|8|62|38|39|3208226304|1185410973696|0|8|63|17|5|6|7|0|1|8|64|17|5|6|7|0|0|-127|-129|-1|-125|8|65|17|5|6|7|0|0|-1|-133|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|67|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|68|14|69|8|70|17|5|6|7|0|3|8|71|14|72|8|73|14|74|8|21|17|5|6|7|0|1|8|73|17|5|6|7|0|1|8|22|14|75|-165|-167|-157|-163|-151|-155|8|76|60|-15|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|-111|8|21|17|5|6|7|0|1|8|57|17|5|6|7|0|1|8|22|14|61|-185|-187|-177|-183|-151|-175|8|34|14|77|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|784073573|1322849927168|8|81|14|79|8|40|38|80|784073573|1322849927168|8|41|14|42|-151|-195|8|44|14|82|8|83|17|5|6|7|0|0|-151|-213|8|21|17|5|6|7|0|1|8|68|17|5|6|7|0|1|8|22|14|84|-219|-221|-151|-217|-147|-149|-143|-145|8|34|14|85|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|784073571|1322849927168|8|81|14|79|8|40|38|80|784073571|1322849927168|8|41|14|42|-143|-229|8|44|14|82|8|86|17|5|6|7|0|0|-143|-247|8|46|14|87|-139|-141|-1|-137|8|88|17|5|6|7|0|3|18|-15|14|89|18|-111|14|90|8|21|17|5|6|7|0|2|18|-15|17|5|6|7|0|1|8|22|14|91|-263|-265|18|-111|17|5|6|7|0|1|8|22|14|92|-263|-271|-255|-261|-1|-253|8|34|14|93|8|94|17|0|8|95|17|5|6|7|0|0|-1|-281|8|96|14|97|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|784073333|1322849927168|8|81|14|79|8|40|38|80|784073489|1322849927168|8|41|14|98|-1|-287|8|99|17|5|6|7|0|2|8|71|14|98|8|73|14|74|-1|-303|8|100|10|11|0|8|101|17|5|6|7|0|0|-1|-314|8|102|10|-313|8|44|14|82|8|103|14|104|8|86|17|5|6|7|0|4|18|-15|14|105|18|-111|14|106|18|19|2|14|107|8|21|17|5|6|7|0|3|18|-15|17|5|6|7|0|1|8|22|14|108|-337|-339|18|-111|17|5|6|7|0|1|8|22|14|109|-337|-345|18|-333|17|5|6|7|0|1|8|22|14|110|-337|-351|-326|-335|-1|-324|8|111|14|112|8|46|14|113|8|83|17|5|6|7|0|2|18|-15|14|114|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|115|-369|-371|-363|-367|-1|-361|8|116|17|5|6|7|0|0|-1|-377|8|117|17|5|6|7|0|0|-1|-381|8|118|17|5|6|7|0|4|8|119|120|121|2|0|8|122|14|122|8|123|14|124|8|125|14|126|-1|-385|8|21|17|5|6|7|0|3|8|103|17|5|6|7|0|1|8|22|14|104|-400|-402|8|13|17|5|6|7|0|1|8|22|14|127|-400|-408|-97|17|5|6|7|0|3|8|29|10|-5|8|94|10|-5|8|103|10|-5|-400|-97|-1|-398|8|128|17|5|6|7|0|14|8|129|14|130|8|131|14|132|8|34|14|133|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|784074037|1322849927168|8|81|14|79|8|40|38|80|784079010|1322849927168|8|41|14|134|-425|-433|8|135|14|136|8|137|17|5|6|7|0|1|18|-15|14|93|-425|-451|8|138|14|139|8|140|17|5|6|7|0|0|-425|-459|8|141|17|5|6|7|0|0|-425|-463|8|44|14|142|8|46|14|143|8|144|14|145|8|146|14|147|-93|17|5|6|7|0|1|-97|17|5|6|7|0|1|-473|10|-5|-476|-97|-425|-93|-1|-423|8|148|17|5|6|7|0|1|8|149|17|5|6|7|0|0|-484|-486|-1|-482|0|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(10)

    # The next 2 HTTP Requests happen after clicking Course Logistics in the left-hand pane
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalLuTypeStartsWith|kuali.lu.type.activity.|lu.search.all.lu.Types|lu.resultColumn.luTypeName|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.atptype.duration|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add_thinktime(10)

    # The next 4 HTTP Requests happen after clicking Save after entering the following Course Logistics info:
    # Change Credit Value to 5
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|144|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|120|courseSpecificLOs|courseTitle|#{new_course_title}|creditOptions|fixedCreditValue|#{new_credit_value}|id|kuali.creditType.credit.degree.3.0|metaInfo|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateTime|versionInd|0|state|Active|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|dirty|updated|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|%%_#{opts[:description_dyn_var]}%%#{new_description_addition}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|createId|#{opts[:modification_person]}|updateId|java.util.Date/1659716317|1|Draft|unitsContentOwner|Lecture|%%_#{opts[:lecture_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|2|outOfClassHours|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{opts[:course_code]}|kuali.atp.season.Winter|kuali.atp.season.Fall|kuali.atp.season.Spring|transcriptTitle|INSECTS|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|Standard final Exam|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|name|Modify: Insects|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{new_proposal_rationale}|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|collaboratorInfo|collaborators|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|3|8|37|38|39|3529482200|1288490188800|0|8|40|38|39|3529482200|1288490188800|0|8|41|14|42|-43|-49|8|43|14|44|8|45|14|46|8|21|17|5|6|7|0|4|8|45|17|5|6|7|0|1|8|22|14|47|-67|-69|8|48|17|5|6|7|0|2|8|32|10|-5|8|45|10|-5|-67|-75|8|49|10|-5|8|21|17|5|6|7|0|1|-75|17|5|6|7|0|1|-83|10|-5|-87|-75|-67|-85|-43|-65|-39|-41|-1|-37|8|50|17|5|6|7|0|0|-1|-93|8|51|17|5|6|7|0|2|8|52|14|53|8|54|14|55|-1|-97|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|19|1|8|21|17|5|6|7|0|2|8|57|17|5|6|7|0|1|8|22|14|61|-116|-118|-75|17|5|6|7|0|1|8|57|10|-5|-116|-75|-107|-114|-1|-105|8|62|38|39|3208226304|1185410973696|0|8|63|17|5|6|7|0|1|8|64|17|5|6|7|0|0|-134|-136|-1|-132|8|65|17|5|6|7|0|0|-1|-140|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|67|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|68|14|69|8|70|17|5|6|7|0|3|8|71|14|72|8|73|14|74|8|21|17|5|6|7|0|1|8|73|17|5|6|7|0|1|8|22|14|75|-172|-174|-164|-170|-158|-162|8|76|60|-15|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|-113|8|21|17|5|6|7|0|1|8|57|17|5|6|7|0|1|8|22|14|61|-192|-194|-184|-190|-158|-182|8|34|14|77|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|516257507|1322849927168|675000000|8|80|14|79|8|40|38|81|516490465|1322849927168|8|41|14|82|-158|-202|8|43|14|83|8|84|17|5|6|7|0|0|-158|-220|8|21|17|5|6|7|0|1|8|68|17|5|6|7|0|1|8|22|14|85|-226|-228|-158|-224|-154|-156|-150|-152|8|34|14|86|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|516257505|1322849927168|673000000|8|80|14|79|8|40|38|81|516490448|1322849927168|8|41|14|82|-150|-236|8|43|14|83|8|87|17|5|6|7|0|0|-150|-254|8|45|14|88|-146|-148|-1|-144|8|89|17|5|6|7|0|2|18|-15|14|90|18|-113|14|91|-1|8|89|8|34|14|92|8|93|17|5|6|7|0|0|-1|-271|8|94|17|5|6|7|0|0|-1|-275|8|95|14|96|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|516257283|1322849927168|451000000|8|80|14|79|8|40|38|81|516490408|1322849927168|8|41|14|97|-1|-281|8|98|17|5|6|7|0|2|8|71|14|82|8|73|14|74|-1|-297|8|99|10|11|0|8|100|17|5|6|7|0|0|-1|-308|8|101|10|-307|8|43|14|83|8|102|14|103|8|87|17|5|6|7|0|3|18|-15|14|104|18|-113|14|105|18|19|2|14|106|-1|8|87|8|107|14|108|8|45|14|109|8|84|17|5|6|7|0|2|18|-15|14|110|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|111|-342|-344|-336|-340|-1|-334|8|112|17|5|6|7|0|0|-1|-350|8|113|17|5|6|7|0|0|-1|-354|8|114|17|5|6|7|0|4|8|115|116|117|2|0|8|118|14|118|8|119|14|120|8|121|14|122|-1|-358|8|21|17|5|6|7|0|3|8|102|17|5|6|7|0|1|8|22|14|103|-373|-375|8|13|17|5|6|7|0|1|8|22|14|123|-373|-381|-75|17|5|6|7|0|3|-329|10|-5|-268|10|-5|8|13|10|-5|-373|-75|-1|-371|8|124|17|5|6|7|0|13|8|125|14|126|8|127|14|128|8|34|14|129|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|516257955|1322849927168|123000000|8|80|14|79|8|40|38|81|516491387|1322849927168|8|41|14|72|-396|-404|8|130|14|131|8|132|17|5|6|7|0|1|18|-15|14|92|-396|-422|8|133|14|134|8|135|17|5|6|7|0|0|-396|-430|8|136|17|5|6|7|0|0|-396|-434|8|137|14|138|8|43|14|139|8|45|14|140|8|141|14|142|-1|-394|8|143|17|5|6|7|0|1|8|144|17|5|6|7|0|0|-448|-450|-1|-446|0|0|"
      },
      {
        'subst' => 'true',
        :dyn_variables => [
        {"name" => opts[:new_credit_id_dyn_var], "re" => opts[:new_credit_id_var_regexp]}
        ]
      }
    )    

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(10)

    # The next 2 HTTP Requests happen after clicking "Active Dates" in the left-hand pane and then selecting "Fall Semester of 2012" for Start Term
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2012-2013|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|6|2|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|19|20|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|23|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2007-2008|atp.advancedAtpSearchParam.atpEndDateAtpConstraintIdExclusive|kuali.atp.FA2012-2013|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|org.kuali.student.common.search.dto.SortDirection/1734387768|1|2|3|4|1|5|5|0|0|6|3|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|7|19|0|20|21|22|23|1|0|"
      }
    )

    @request.add_thinktime(10)

    # The next 4 HTTP Requests happen after clicking Save
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|153|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|120|courseSpecificLOs|courseTitle|#{new_course_title}|creditOptions|fixedCreditValue|#{new_credit_value}|id|%%_#{opts[:new_credit_id_dyn_var]}%%|metaInfo|createId|#{opts[:modification_person]}|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.util.Date/1659716317|updateId|updateTime|versionInd|0|resultValues|5.0|state|Draft|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|%%_#{opts[:description_dyn_var]}%%#{new_description_addition}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|java.sql.Timestamp/1769758459|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|2|unitsContentOwner|Lecture|%%_#{opts[:lecture_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|Letter|Pass-Fail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|outOfClassHours|1|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{opts[:course_code]}|kuali.atp.season.Winter|kuali.atp.season.Fall|kuali.atp.season.Spring|Winter|Fall|Spring|transcriptTitle|INSECTS|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|Standard final Exam|dirty|startTerm|endTerm|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|4|name|Modify: Insects|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{new_proposal_rationale}|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|collaboratorInfo|collaborators|kuali.atp.FA2012-2013|1|2|3|4|1|5|5|6|7|0|40|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|41|517712593|1322849927168|8|42|14|38|8|43|40|41|517712593|1322849927168|8|44|14|45|-43|-49|8|46|17|5|6|7|0|1|18|-15|14|47|-43|-65|8|48|14|49|8|50|14|51|8|21|17|5|6|7|0|1|8|50|17|5|6|7|0|1|8|22|14|52|-77|-79|-43|-75|-39|-41|-1|-37|8|53|17|5|6|7|0|0|-1|-85|8|54|17|5|6|7|0|2|8|55|14|56|8|57|14|58|-1|-89|8|59|17|5|6|7|0|3|8|60|14|61|8|62|63|19|1|8|21|17|5|6|7|0|1|8|60|17|5|6|7|0|1|8|22|14|64|-108|-110|-99|-106|-1|-97|8|65|40|66|3208226304|1185410973696|0|8|67|17|5|6|7|0|1|8|68|17|5|6|7|0|0|-121|-123|-1|-119|8|69|17|5|6|7|0|0|-1|-127|8|70|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|71|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|72|14|73|8|74|17|5|6|7|0|3|8|75|14|76|8|77|14|78|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|79|-159|-161|-151|-157|-145|-149|8|80|63|-15|8|59|17|5|6|7|0|3|8|60|14|61|8|62|63|-105|8|21|17|5|6|7|0|1|8|60|17|5|6|7|0|1|8|22|14|64|-179|-181|-171|-177|-145|-169|8|34|14|81|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|516257507|1322849927168|675000000|8|42|14|38|8|43|40|41|517712554|1322849927168|8|44|14|82|-145|-189|8|48|14|49|8|83|17|5|6|7|0|0|-145|-207|8|21|17|5|6|7|0|1|8|72|17|5|6|7|0|1|8|22|14|84|-213|-215|-145|-211|-141|-143|-137|-139|8|34|14|85|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|516257505|1322849927168|673000000|8|42|14|38|8|43|40|41|517712542|1322849927168|8|44|14|82|-137|-223|8|48|14|49|8|86|17|5|6|7|0|0|-137|-241|8|50|14|87|-133|-135|-1|-131|8|88|17|5|6|7|0|3|18|-15|14|89|18|-105|14|90|8|21|17|5|6|7|0|2|18|-15|17|5|6|7|0|1|8|22|14|91|-257|-259|18|-105|17|5|6|7|0|1|8|22|14|92|-257|-265|-249|-255|-1|-247|8|34|14|93|8|94|17|5|6|7|0|0|-1|-273|8|95|17|5|6|7|0|0|-1|-277|8|96|14|97|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|516257283|1322849927168|451000000|8|42|14|38|8|43|40|41|517712503|1322849927168|8|44|14|76|-1|-283|8|98|17|5|6|7|0|2|8|75|14|99|8|77|14|78|-1|-299|8|100|10|11|0|8|101|17|5|6|7|0|0|-1|-310|8|102|10|-309|8|48|14|49|8|103|14|104|8|86|17|5|6|7|0|4|18|-15|14|105|18|-105|14|106|18|19|2|14|107|8|21|17|5|6|7|0|3|18|-15|17|5|6|7|0|1|8|22|14|108|-333|-335|18|-105|17|5|6|7|0|1|8|22|14|109|-333|-341|18|-329|17|5|6|7|0|1|8|22|14|110|-333|-347|-322|-331|-1|-320|8|111|14|112|8|50|14|113|8|83|17|5|6|7|0|2|18|-15|14|114|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|115|-365|-367|-359|-363|-1|-357|8|116|17|5|6|7|0|0|-1|-373|8|117|17|5|6|7|0|0|-1|-377|8|118|17|5|6|7|0|4|8|119|120|121|2|0|8|122|14|122|8|123|14|124|8|125|14|126|-1|-381|8|21|17|5|6|7|0|3|8|103|17|5|6|7|0|1|8|22|14|104|-396|-398|8|13|17|5|6|7|0|1|8|22|14|127|-396|-404|8|128|17|5|6|7|0|2|8|129|10|-5|8|130|10|-5|-396|-410|-1|-394|8|131|17|5|6|7|0|13|8|132|14|133|8|134|14|135|8|34|14|136|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|516257955|1322849927168|123000000|8|42|14|38|8|43|40|41|517713532|1322849927168|8|44|14|137|-420|-428|8|138|14|139|8|140|17|5|6|7|0|1|18|-15|14|93|-420|-446|8|141|14|142|8|143|17|5|6|7|0|0|-420|-454|8|144|17|5|6|7|0|0|-420|-458|8|145|14|146|8|48|14|147|8|50|14|148|8|149|14|150|-1|-418|8|151|17|5|6|7|0|1|8|152|17|5|6|7|0|0|-472|-474|-1|-470|-414|14|153|-416|14|0|0|0|"
      }, {'subst' => 'true',
          :dyn_variables => [
          {"name" => opts[:new_active_date_dyn_var], "re" => opts[:new_active_date_var_regexp]}
        ]
        }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(10)

    # The next 5 HTTP Requests happen after clicking "Review Proposal" in the left-hand pane
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5771428875B68D3E8EC7527EC8D18D40|org.kuali.student.core.document.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:preRoute_dyn_var]}%%|1|2|3|4|2|5|5|6|7|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|151|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|validate|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|120|courseSpecificLOs|courseTitle|#{new_course_title}|creditOptions|fixedCreditValue|#{new_credit_value}|id|%%_#{opts[:new_credit_id_dyn_var]}%%|metaInfo|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateTime|versionInd|0|resultValues|state|Active|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|%%_#{opts[:description_dyn_var]}%%#{new_description_addition}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|createId|#{opts[:modification_person]}|updateId|java.util.Date/1659716317|Draft|unitsContentOwner|Lecture|%%_#{opts[:lecture_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|Letter|Pass-Fail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|4|outOfClassHours|1|pilotCourse|revenues|specialTopicsCourse|startTerm|kuali.atp.FA2012-2013|subjectArea|#{opts[:course_code]}|kuali.atp.season.Winter|kuali.atp.season.Fall|kuali.atp.season.Spring|Winter|Fall|Spring|transcriptTitle|INSECTS|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|%%_#{opts[:new_active_date_dyn_var]}%%|Standard final Exam|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|name|Modify: Insects|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{new_proposal_rationale}|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|collaboratorInfo|collaborators|1|2|3|4|1|5|5|6|7|0|39|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|3|8|37|38|39|3529482200|1288490188800|0|8|40|38|39|3529482200|1288490188800|0|8|41|14|42|-43|-49|8|43|17|5|6|7|0|0|-43|-61|8|44|14|45|8|46|14|47|8|21|17|5|6|7|0|1|8|46|17|5|6|7|0|1|8|22|14|48|-71|-73|-43|-69|-39|-41|-1|-37|8|49|17|5|6|7|0|0|-1|-79|8|50|17|5|6|7|0|2|8|51|14|52|8|53|14|54|-1|-83|8|55|17|5|6|7|0|3|8|56|14|57|8|58|59|19|1|8|21|17|5|6|7|0|1|8|56|17|5|6|7|0|1|8|22|14|60|-102|-104|-93|-100|-1|-91|8|61|38|39|2147236352|1344324763648|0|8|62|17|5|6|7|0|1|8|63|17|5|6|7|0|0|-115|-117|-1|-113|8|64|17|5|6|7|0|0|-1|-121|8|65|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|67|14|68|8|69|17|5|6|7|0|3|8|70|14|71|8|72|14|73|8|21|17|5|6|7|0|1|8|72|17|5|6|7|0|1|8|22|14|74|-153|-155|-145|-151|-139|-143|8|75|59|-15|8|55|17|5|6|7|0|3|8|56|14|57|8|58|59|-99|8|21|17|5|6|7|0|1|8|56|17|5|6|7|0|1|8|22|14|60|-173|-175|-165|-171|-139|-163|8|34|14|76|8|36|17|5|6|7|0|5|8|77|14|78|8|37|38|39|940943525|1322849927168|693000000|8|79|14|78|8|40|38|80|941061636|1322849927168|8|41|14|71|-139|-183|8|44|14|81|8|82|17|5|6|7|0|0|-139|-201|8|21|17|5|6|7|0|1|8|67|17|5|6|7|0|1|8|22|14|83|-207|-209|-139|-205|-135|-137|-131|-133|8|34|14|84|8|36|17|5|6|7|0|5|8|77|14|78|8|37|38|39|940943524|1322849927168|692000000|8|79|14|78|8|40|38|80|941061627|1322849927168|8|41|14|71|-131|-217|8|44|14|81|8|85|17|5|6|7|0|0|-131|-235|8|46|14|86|-127|-129|-1|-125|8|87|17|5|6|7|0|3|18|-15|14|88|18|-99|14|89|8|21|17|5|6|7|0|2|18|-15|17|5|6|7|0|1|8|22|14|90|-251|-253|18|-99|17|5|6|7|0|1|8|22|14|91|-251|-259|-243|-249|-1|-241|8|34|14|92|8|93|17|5|6|7|0|0|-1|-267|8|94|17|5|6|7|0|0|-1|-271|8|95|14|96|8|36|17|5|6|7|0|5|8|77|14|78|8|37|38|39|940943386|1322849927168|554000000|8|79|14|78|8|40|38|80|941061602|1322849927168|8|41|14|97|-1|-277|8|98|17|5|6|7|0|2|8|70|14|99|8|72|14|73|-1|-293|8|100|10|11|0|8|101|17|5|6|7|0|0|-1|-304|8|102|10|-303|8|103|14|104|8|44|14|81|8|105|14|106|8|85|17|5|6|7|0|4|18|-15|14|107|18|-99|14|108|18|19|2|14|109|8|21|17|5|6|7|0|3|18|-15|17|5|6|7|0|1|8|22|14|110|-329|-331|18|-99|17|5|6|7|0|1|8|22|14|111|-329|-337|18|-325|17|5|6|7|0|1|8|22|14|112|-329|-343|-318|-327|-1|-316|8|113|14|114|8|46|14|115|8|82|17|5|6|7|0|2|18|-15|14|116|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|117|-361|-363|-355|-359|-1|-353|8|118|17|5|6|7|0|0|-1|-369|8|119|17|5|6|7|0|0|-1|-373|8|120|17|5|6|7|0|4|8|121|122|123|4|0|8|124|14|124|8|125|14|126|8|127|14|128|-1|-377|8|21|17|5|6|7|0|3|8|103|17|5|6|7|0|1|8|22|14|129|-392|-394|8|105|17|5|6|7|0|1|8|22|14|106|-392|-400|8|13|17|5|6|7|0|1|8|22|14|130|-392|-406|-1|-390|8|131|17|5|6|7|0|13|8|132|14|133|8|134|14|135|8|34|14|136|8|36|17|5|6|7|0|5|8|77|14|78|8|37|38|39|940943729|1322849927168|897000000|8|79|14|78|8|40|38|80|941062268|1322849927168|8|41|14|33|-414|-422|8|137|14|138|8|139|17|5|6|7|0|1|18|-15|14|92|-414|-440|8|140|14|141|8|142|17|5|6|7|0|0|-414|-448|8|143|17|5|6|7|0|0|-414|-452|8|144|14|145|8|44|14|146|8|46|14|147|8|148|14|149|-1|-412|8|150|17|5|6|7|0|1|8|151|17|5|6|7|0|0|-466|-468|-1|-464|0|0|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(10)

    # The next 4 HTTP Requests happen after clicking "Cancel Proposal" in the Proposal Actions dropdown and then clicking "Yes, cancel proposal" in the popup
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|cancelDocumentWithId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(3)

  end


  # Propose Course Modification with Requisite
  def propose_course_mod_with_requisite(course_code, course_title, course_number, new_course_title, new_description_addition, new_proposal_rationale, new_credit_value, advanced_search_code, requisite,  opts={})

    defaults = {
      :modification_person => '%%_username%%', #user is the dynvar from users.csv
      :nav_homepage => true,      
      :course_name_dyn_var => 'course_name_dyn_var',
      :course_name_var_regexp => '([^\"]+)\"\,\"[^\"]+\"\,\"' + course_title,
      :course_ind_dyn_var => 'course_ind_dyn_var',
      :course_ind_var_regexp => 'versionIndId\"\,\"([^\"]+)',
      :pass_fail_dyn_var => 'pass_fail_dyn_var',
      :pass_fail_var_regexp => 'Pass-Fail\"\,\"([^\"]+)',
      :description_dyn_var => 'description_dyn_var',
      :description_var_regexp => '\"descr\"\,\"formatted\"\,\"([^\"]+)',
      :new_credit_id_dyn_var => 'new_credit_dyn_var',
      :new_credit_id_var_regexp => '\"fixedCreditValue\"\,\"[^\"]+\"\,\"[^\"]+\"\,\"([^\"]+)',
      :defaultEnrollmentEstimate_dyn_var => 'defaultEnrollmentEstimate_dyn_var',
      :defaultEnrollmentEstimate_var_regexp => 'defaultEnrollmentEstimate\"\,\"([^\"]+)',
      :lecture_dyn_var => 'lecture_dyn_var',
      :lecture_var_regexp => '\"Lecture\"\,\"[^\"]+\"\,\"[^\"]+\"\,\"([^\"]+)',
      :lab_dyn_var => 'lab_dyn_var',
      :lab_var_regexp => '\"Lab\"\,\"([^\"]+)',
      :preRoute_dyn_var => 'preRoute_dyn_var',
      :preRoute_var_regexp => 'PreRoute\"\,\"([^\"]+)',
      :workflowId_dyn_var => 'workflowId_dyn_var',
      :workflowId_var_regexp => 'workflowId\"\,\"([^\"]+)',
      :new_active_date_dyn_var => 'new_active_date_dyn_var',
      :new_active_date_var_regexp => '([^\"]+)\"\,\"Standard final Exam',
      :requisite_ind_dyn_var => 'requisite_ind_dyn_var',
      :requisite_ind_var_regexp => 'VersionIndId\"\,\"([^\"]+)',
      :required_dyn_var => 'required_dyn_var',
      :required_var_regexp => '(Must have successfully completed ' + requisite +')'
      # :course_name_var_regexp => '\"([^\"]+)\"\,\"[^\"]+\"\,\"' + course_name + '\"'
      #NOTE: The previous regexp returns the text of the word that is 2 words behind the coures name in the comma delimitted http response. NOTE: The quotation marks surrounding the text are stripped.      
      # This word is then included in 2 HTTP Requests that are sent later.
    }
    
    opts = defaults.merge(opts)
  
    # Navigate to Curriculum Mgmt
    self.homepage() unless(!opts[:nav_homepage])

    # The following HTTP Request happens after entering Course Code BSCI and clicking Search
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.lang.Integer/3438268394|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalCode|#{course_code}|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.queryParam.luOptionalState|java.lang.String/2004016611|Approved|Active|Retired|lu.search.mostCurrent.union|lu.resultColumn.luOptionalCode|1|2|3|4|1|5|5|6|10|7|0|8|3|9|10|0|11|9|12|0|13|9|14|8|3|15|16|15|17|15|18|0|19|20|0|6|0|"
      },
      {
        :dyn_variables => [
          {"name" => opts[:course_name_dyn_var], "re" => opts[:course_name_var_regexp]}
        ]
      }
    )

    # The following 19 HTTP Requests happen after clicking on the row with Name = "Microbes and Society" and Code = "BSCI122"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getMetadata|java.lang.String/2004016611|java.util.Map||1|2|3|4|2|5|6|7|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # DUPE 
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    # DUPE 
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.campusLocation|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    # DUPE
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getData|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true',
          :dyn_variables => [
          {"name" => opts[:course_ind_dyn_var], "re" => opts[:course_ind_var_regexp]}
        ]
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|isLatestVersion|java.lang.String/2004016611|java.lang.Long/4227064769|%%_#{opts[:course_ind_dyn_var]}%%|1|2|3|4|2|5|6|7|6|1|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:modification_person]}|cluModifyItem|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(3)

    # The next 41 HTTP Requests happen after clicking "Propose Course Modification" in the Course Actions dropdown list
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:modification_person]}|cluModifyItem|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|isLatestVersion|java.lang.String/2004016611|java.lang.Long/4227064769|%%_#{opts[:course_ind_dyn_var]}%%|1|2|3|4|2|5|6|7|6|1|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|10|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|isAuthorized|org.kuali.student.common.rice.authorization.PermissionType/1943437355|java.util.Map|java.util.HashMap/962170901|java.lang.String/2004016611|copyOfObjectId|%%_#{opts[:course_ind_dyn_var]}%%|1|2|3|4|2|5|6|5|0|7|1|8|9|8|10|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|17|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|proposal|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|type|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|kuali.proposal.type.course.modify|versionInfo|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionComment|1|2|3|4|1|5|5|6|7|0|2|8|9|10|5|6|7|0|1|8|11|12|13|-1|-3|8|14|10|5|6|7|0|2|8|15|12|16|8|17|12|17|-1|-9|0|0|"
      }, {'subst' => 'true',
          :dyn_variables => [
          {"name" => opts[:pass_fail_dyn_var], "re" => opts[:pass_fail_var_regexp]},
          {"name" => opts[:description_dyn_var], "re" => opts[:description_var_regexp]},
          {"name" => opts[:defaultEnrollmentEstimate_dyn_var], "re" => opts[:defaultEnrollmentEstimate_var_regexp]},
          {"name" => opts[:lecture_dyn_var], "re" => opts[:lecture_var_regexp]},
          {"name" => opts[:lab_dyn_var], "re" => opts[:lab_var_regexp]},
          {"name" => opts[:preRoute_dyn_var], "re" => opts[:preRoute_var_regexp]},
          {"name" => opts[:workflowId_dyn_var], "re" => opts[:workflowId_var_regexp]}
        ]
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getData|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:pass_fail_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|%%_#{opts[:preRoute_dyn_var]}%%|java.util.HashMap/962170901|ID_TYPE|kualiStudentObjectWorkflowId|documentTypeName|kuali.proposal.type.course.modify|DtoState|Draft|DtoNextState||DtoWorkflowNode|PreRoute|1|2|3|4|2|5|6|7|8|5|5|9|5|10|5|11|5|12|5|13|5|14|5|15|5|16|5|17|5|18|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:course_name_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpDurationTypes|atp.resultColumn.atpDurTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.finalExam.status|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponentType.credit.degree.fixed|kuali.resultComponentType.credit.degree.range|kuali.resultComponentType.credit.degree.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|1|7|8|6|3|9|10|9|11|9|12|0|13|14|0|0|"
      }
    )

    # Dupe
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponentType.credit.degree.fixed|kuali.resultComponentType.credit.degree.range|kuali.resultComponentType.credit.degree.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|1|7|8|6|3|9|10|9|11|9|12|0|13|14|0|0|"
      }
    )

    # Dupe
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponentType.credit.degree.fixed|kuali.resultComponentType.credit.degree.range|kuali.resultComponentType.credit.degree.multiple|lrc.search.resultComponentType|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|1|7|8|6|3|9|10|9|11|9|12|0|13|14|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # Dupe
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # Dupe
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    # Dupe
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.lu.fee.rateType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CommentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|62D53D0C5087061126A72510E98E7E9A|org.kuali.student.core.comments.ui.client.service.CommentRpcService|getUserRealName|java.lang.String/2004016611|#{opts[:modification_person]}|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|22|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2007-2008|atp.advancedAtpSearchParam.atpEndDateAtpConstraintIdExclusive|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|org.kuali.student.common.search.dto.SortDirection/1734387768|1|2|3|4|1|5|5|0|0|6|3|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|7|19|0|0|20|21|22|1|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5771428875B68D3E8EC7527EC8D18D40|org.kuali.student.core.document.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:preRoute_dyn_var]}%%|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|subjectCode.queryParam.code||subjectCode.search.orgsForSubjectCode|subjectCode.resultColumn.orgLongName|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintIdExclusive|kuali.atp.FA2007-2008|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|6|2|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|19|20|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|22|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2007-2008|atp.advancedAtpSearchParam.atpEndDateAtpConstraintIdExclusive|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|org.kuali.student.common.search.dto.SortDirection/1734387768|1|2|3|4|1|5|5|0|0|6|3|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|7|19|0|0|20|21|22|1|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|19|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|6|2|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|0|18|19|0|0|"
      }
    )


    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
     {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|148|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|validate|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|122|courseSpecificLOs|courseTitle|#{course_title}|creditOptions|fixedCreditValue|4.0|id|kuali.creditType.credit.degree.4.0|metaInfo|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateTime|versionInd|0|resultValues|state|Active|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|createId|#{opts[:modification_person]}|java.util.Date/1659716317|updateId|Draft|unitsContentOwner|Lecture|kuali.lu.type.activity.Lab|2|%%_#{opts[:lecture_dyn_var]}%%|Lab|%%_#{opts[:lab_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|Letter|Pass-Fail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|1|outOfClassHours|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{course_code}|kuali.atp.season.Fall|kuali.atp.season.Winter|kuali.atp.season.Spring|Fall|Winter|Spring|transcriptTitle|MICROBES AND SOCIETY|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|Standard final Exam|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|name|Modify: Microbes and Society|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|collaboratorInfo|collaborators|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|3|8|37|38|39|3529485200|1288490188800|0|8|40|38|39|3529485200|1288490188800|0|8|41|14|42|-43|-49|8|43|17|5|6|7|0|1|18|-15|14|33|-43|-61|8|44|14|45|8|46|14|47|8|21|17|5|6|7|0|1|8|46|17|5|6|7|0|1|8|22|14|48|-73|-75|-43|-71|-39|-41|-1|-37|8|49|17|5|6|7|0|0|-1|-81|8|50|17|5|6|7|0|2|8|51|14|52|8|53|14|52|-1|-85|8|54|17|5|6|7|0|3|8|55|14|56|8|57|58|19|1|8|21|17|5|6|7|0|1|8|55|17|5|6|7|0|1|8|22|14|59|-104|-106|-95|-102|-1|-93|8|60|38|39|3208226304|1185410973696|0|8|61|17|5|6|7|0|1|8|62|17|5|6|7|0|0|-117|-119|-1|-115|8|63|17|5|6|7|0|0|-1|-123|8|64|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|65|17|5|6|7|0|2|18|-15|17|5|6|7|0|9|8|66|14|67|8|68|17|5|6|7|0|3|8|69|14|70|8|71|14|72|8|21|17|5|6|7|0|1|8|71|17|5|6|7|0|1|8|22|14|73|-155|-157|-147|-153|-141|-145|8|74|58|-15|8|54|17|5|6|7|0|3|8|55|14|56|8|57|58|-101|8|21|17|5|6|7|0|1|8|55|17|5|6|7|0|1|8|22|14|59|-175|-177|-167|-173|-141|-165|8|34|14|75|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|1124274752|1322849927168|8|79|14|77|8|40|38|78|1124274752|1322849927168|8|41|14|42|-141|-185|8|44|14|80|8|81|17|5|6|7|0|0|-141|-203|8|21|17|5|6|7|0|1|8|66|17|5|6|7|0|1|8|22|14|82|-209|-211|-141|-207|-137|-139|18|-101|17|5|6|7|0|9|8|66|14|83|8|68|17|5|6|7|0|3|8|69|14|84|8|71|14|72|8|21|17|5|6|7|0|1|8|71|17|5|6|7|0|1|8|22|14|73|-233|-235|-225|-231|-219|-223|8|74|58|-15|8|54|17|5|6|7|0|3|8|55|14|56|8|57|58|-101|8|21|17|5|6|7|0|1|8|55|17|5|6|7|0|1|8|22|14|59|-253|-255|-245|-251|-219|-243|8|34|14|85|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|1124274766|1322849927168|8|79|14|77|8|40|38|78|1124274766|1322849927168|8|41|14|42|-219|-263|8|44|14|80|8|81|17|5|6|7|0|0|-219|-281|8|21|17|5|6|7|0|1|8|66|17|5|6|7|0|1|8|22|14|86|-287|-289|-219|-285|-137|-217|-133|-135|8|34|14|87|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|1124274750|1322849927168|8|79|14|77|8|40|38|78|1124274750|1322849927168|8|41|14|42|-133|-297|8|44|14|80|8|88|17|5|6|7|0|0|-133|-315|8|46|14|89|-129|-131|-1|-127|8|90|17|5|6|7|0|3|18|-15|14|91|18|-101|14|92|8|21|17|5|6|7|0|2|18|-15|17|5|6|7|0|1|8|22|14|93|-331|-333|18|-101|17|5|6|7|0|1|8|22|14|94|-331|-339|-323|-329|-1|-321|8|34|14|95|8|96|17|5|6|7|0|0|-1|-347|8|97|17|5|6|7|0|0|-1|-351|8|98|14|99|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|1124274485|1322849927168|8|79|14|77|8|40|38|78|1124274661|1322849927168|8|41|14|100|-1|-357|8|101|17|5|6|7|0|2|8|69|14|100|8|71|14|72|-1|-373|8|102|10|11|0|8|103|17|5|6|7|0|0|-1|-384|8|104|10|-383|8|44|14|80|8|105|14|106|8|88|17|5|6|7|0|4|18|-15|14|107|18|-101|14|108|18|19|2|14|109|8|21|17|5|6|7|0|3|18|-15|17|5|6|7|0|1|8|22|14|110|-407|-409|18|-101|17|5|6|7|0|1|8|22|14|111|-407|-415|18|-403|17|5|6|7|0|1|8|22|14|112|-407|-421|-396|-405|-1|-394|8|113|14|114|8|46|14|115|8|81|17|5|6|7|0|2|18|-15|14|116|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|117|-439|-441|-433|-437|-1|-431|8|118|17|5|6|7|0|0|-1|-447|8|119|17|5|6|7|0|0|-1|-451|8|120|17|5|6|7|0|4|8|121|122|123|2|0|8|124|14|124|8|125|14|126|8|127|14|128|-1|-455|8|21|17|5|6|7|0|2|8|105|17|5|6|7|0|1|8|22|14|106|-470|-472|8|13|17|5|6|7|0|1|8|22|14|129|-470|-478|-1|-468|8|130|17|5|6|7|0|12|8|131|14|132|8|133|14|134|8|34|14|135|8|36|17|5|6|7|0|5|8|76|14|77|8|37|38|78|1124275211|1322849927168|8|79|14|77|8|40|38|78|1124280435|1322849927168|8|41|14|84|-486|-494|8|136|14|137|8|138|17|5|6|7|0|1|18|-15|14|95|-486|-512|8|139|14|140|8|141|17|5|6|7|0|0|-486|-520|8|142|17|5|6|7|0|0|-486|-524|8|44|14|143|8|46|14|144|8|145|14|146|-1|-484|8|147|17|5|6|7|0|1|8|148|17|5|6|7|0|0|-536|-538|-1|-534|0|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|22|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2007-2008|atp.advancedAtpSearchParam.atpEndDateAtpConstraintIdExclusive|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|org.kuali.student.common.search.dto.SortDirection/1734387768|1|2|3|4|1|5|5|0|0|6|3|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|7|19|0|0|20|21|22|1|0|"
      }
    )

    @request.add_thinktime(10)

    # The next HTTP Request happens after clicking "Edit", which is located to the right of "Course Information" which is to the right of the left-hand pane
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|subjectCode.queryParam.code|#{course_code}|subjectCode.search.orgsForSubjectCode|subjectCode.resultColumn.orgLongName|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add_thinktime(10)

    # The next 4 HTTP Requests happen after clicking "Save" after modifying Course Information as follows:
    # Change course title to "Microbes and American Society"
    # Add "Focus on America" to the end of the description
    # Enter "because america has the best microbes" for Proposal Rationale
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|152|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|122|courseSpecificLOs|courseTitle|#{new_course_title}|creditOptions|fixedCreditValue|4.0|id|kuali.creditType.credit.degree.4.0|metaInfo|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateTime|versionInd|0|resultValues|state|Active|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|%%_#{opts[:description_dyn_var]}%%#{new_description_addition}|dirty|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|createId|#{opts[:modification_person]}|java.util.Date/1659716317|updateId|Draft|unitsContentOwner|Lecture|kuali.lu.type.activity.Lab|2|%%_#{opts[:lecture_dyn_var]}%%|Lab|%%_#{opts[:lab_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|Letter|Pass-Fail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|1|outOfClassHours|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{course_code}|kuali.atp.season.Fall|kuali.atp.season.Winter|kuali.atp.season.Spring|Fall|Winter|Spring|transcriptTitle|MICROBES AND SOCIETY|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|Standard final Exam|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|name|Modify: #{course_title}|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|rationale|#{new_proposal_rationale}|collaboratorInfo|collaborators|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|3|8|37|38|39|3529485200|1288490188800|0|8|40|38|39|3529485200|1288490188800|0|8|41|14|42|-43|-49|8|43|17|5|6|7|0|1|18|-15|14|33|-43|-61|8|44|14|45|8|46|14|47|8|21|17|5|6|7|0|1|8|46|17|5|6|7|0|1|8|22|14|48|-73|-75|-43|-71|-39|-41|-1|-37|8|49|17|5|6|7|0|0|-1|-81|8|50|17|5|6|7|0|3|8|51|14|52|8|53|14|54|8|21|17|5|6|7|0|1|8|55|17|5|6|7|0|1|8|53|10|-5|-95|-97|-87|-93|-1|-85|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|19|1|8|21|17|5|6|7|0|1|8|57|17|5|6|7|0|1|8|22|14|61|-114|-116|-105|-112|-1|-103|8|62|38|39|3208226304|1185410973696|0|8|63|17|5|6|7|0|1|8|64|17|5|6|7|0|0|-127|-129|-1|-125|8|65|17|5|6|7|0|0|-1|-133|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|67|17|5|6|7|0|2|18|-15|17|5|6|7|0|9|8|68|14|69|8|70|17|5|6|7|0|3|8|71|14|72|8|73|14|74|8|21|17|5|6|7|0|1|8|73|17|5|6|7|0|1|8|22|14|75|-165|-167|-157|-163|-151|-155|8|76|60|-15|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|-111|8|21|17|5|6|7|0|1|8|57|17|5|6|7|0|1|8|22|14|61|-185|-187|-177|-183|-151|-175|8|34|14|77|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|1565163205|1322849927168|8|81|14|79|8|40|38|80|1565163205|1322849927168|8|41|14|42|-151|-195|8|44|14|82|8|83|17|5|6|7|0|0|-151|-213|8|21|17|5|6|7|0|1|8|68|17|5|6|7|0|1|8|22|14|84|-219|-221|-151|-217|-147|-149|18|-111|17|5|6|7|0|9|8|68|14|85|8|70|17|5|6|7|0|3|8|71|14|86|8|73|14|74|8|21|17|5|6|7|0|1|8|73|17|5|6|7|0|1|8|22|14|75|-243|-245|-235|-241|-229|-233|8|76|60|-15|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|-111|8|21|17|5|6|7|0|1|8|57|17|5|6|7|0|1|8|22|14|61|-263|-265|-255|-261|-229|-253|8|34|14|87|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|1565163219|1322849927168|8|81|14|79|8|40|38|80|1565163219|1322849927168|8|41|14|42|-229|-273|8|44|14|82|8|83|17|5|6|7|0|0|-229|-291|8|21|17|5|6|7|0|1|8|68|17|5|6|7|0|1|8|22|14|88|-297|-299|-229|-295|-147|-227|-143|-145|8|34|14|89|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|1565163203|1322849927168|8|81|14|79|8|40|38|80|1565163203|1322849927168|8|41|14|42|-143|-307|8|44|14|82|8|90|17|5|6|7|0|0|-143|-325|8|46|14|91|-139|-141|-1|-137|8|92|17|5|6|7|0|3|18|-15|14|93|18|-111|14|94|8|21|17|5|6|7|0|2|18|-15|17|5|6|7|0|1|8|22|14|95|-341|-343|18|-111|17|5|6|7|0|1|8|22|14|96|-341|-349|-333|-339|-1|-331|8|34|14|97|8|98|17|0|8|99|17|5|6|7|0|0|-1|-359|8|100|14|101|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|1565162823|1322849927168|8|81|14|79|8|40|38|80|1565163048|1322849927168|8|41|14|102|-1|-365|8|103|17|5|6|7|0|2|8|71|14|102|8|73|14|74|-1|-381|8|104|10|11|0|8|105|17|5|6|7|0|0|-1|-392|8|106|10|-391|8|44|14|82|8|107|14|108|8|90|17|5|6|7|0|4|18|-15|14|109|18|-111|14|110|18|19|2|14|111|8|21|17|5|6|7|0|3|18|-15|17|5|6|7|0|1|8|22|14|112|-415|-417|18|-111|17|5|6|7|0|1|8|22|14|113|-415|-423|18|-411|17|5|6|7|0|1|8|22|14|114|-415|-429|-404|-413|-1|-402|8|115|14|116|8|46|14|117|8|83|17|5|6|7|0|2|18|-15|14|118|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|119|-447|-449|-441|-445|-1|-439|8|120|17|5|6|7|0|0|-1|-455|8|121|17|5|6|7|0|0|-1|-459|8|122|17|5|6|7|0|4|8|123|124|125|2|0|8|126|14|126|8|127|14|128|8|129|14|130|-1|-463|8|21|17|5|6|7|0|3|8|107|17|5|6|7|0|1|8|22|14|108|-478|-480|8|13|17|5|6|7|0|1|8|22|14|131|-478|-486|-97|17|5|6|7|0|3|8|29|10|-5|8|98|10|-5|8|107|10|-5|-478|-97|-1|-476|8|132|17|5|6|7|0|14|8|133|14|134|8|135|14|136|8|34|14|137|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|80|1565163837|1322849927168|8|81|14|79|8|40|38|80|1565169104|1322849927168|8|41|14|86|-503|-511|8|138|14|139|8|140|17|5|6|7|0|1|18|-15|14|97|-503|-529|8|141|14|142|8|143|17|5|6|7|0|0|-503|-537|8|144|17|5|6|7|0|0|-503|-541|8|44|14|145|8|46|14|146|8|147|14|148|8|149|14|150|-93|17|5|6|7|0|1|-97|17|5|6|7|0|1|-551|10|-5|-554|-97|-503|-93|-1|-501|8|151|17|5|6|7|0|1|8|152|17|5|6|7|0|0|-562|-564|-1|-560|0|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(10)

    # The next 4 HTTP Requests happen after clicking "Course Logistics" in the left-hand pane
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalLuTypeStartsWith|kuali.lu.type.activity.|lu.search.all.lu.Types|lu.resultColumn.luTypeName|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.atptype.duration|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalLuTypeStartsWith|kuali.lu.type.activity.|lu.search.all.lu.Types|lu.resultColumn.luTypeName|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|enumeration.queryParam.enumerationType|kuali.atptype.duration|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
      }
    )

    @request.add_thinktime(10)

    # The next 4 HTTP Requests happen after changing the credit value to 5 and clicking "Save"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|147|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|122|courseSpecificLOs|courseTitle|#{new_course_title}|creditOptions|fixedCreditValue|#{new_credit_value}|id|kuali.creditType.credit.degree.4.0|metaInfo|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.sql.Timestamp/1769758459|updateTime|versionInd|0|state|Active|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|dirty|updated|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|%%_#{opts[:description_dyn_var]}%%#{new_description_addition}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|createId|#{opts[:modification_person]}|updateId|java.util.Date/1659716317|1|Draft|unitsContentOwner|Lecture|kuali.lu.type.activity.Lab|2|%%_#{opts[:lecture_dyn_var]}%%|Lab|%%_#{opts[:lab_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|outOfClassHours|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{course_code}|kuali.atp.season.Fall|kuali.atp.season.Winter|kuali.atp.season.Spring|transcriptTitle|MICROBES AND SOCIETY|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|Standard final Exam|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|name|Modify: #{course_title}|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{new_proposal_rationale}|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|collaboratorInfo|collaborators|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|3|8|37|38|39|3529485200|1288490188800|0|8|40|38|39|3529485200|1288490188800|0|8|41|14|42|-43|-49|8|43|14|44|8|45|14|46|8|21|17|5|6|7|0|4|8|45|17|5|6|7|0|1|8|22|14|47|-67|-69|8|48|17|5|6|7|0|2|8|32|10|-5|8|45|10|-5|-67|-75|8|49|10|-5|8|21|17|5|6|7|0|1|-75|17|5|6|7|0|1|-83|10|-5|-87|-75|-67|-85|-43|-65|-39|-41|-1|-37|8|50|17|5|6|7|0|0|-1|-93|8|51|17|5|6|7|0|2|8|52|14|53|8|54|14|55|-1|-97|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|19|1|8|21|17|5|6|7|0|2|8|57|17|5|6|7|0|1|8|22|14|61|-116|-118|-75|17|5|6|7|0|1|8|57|10|-5|-116|-75|-107|-114|-1|-105|8|62|38|39|3208226304|1185410973696|0|8|63|17|5|6|7|0|1|8|64|17|5|6|7|0|0|-134|-136|-1|-132|8|65|17|5|6|7|0|0|-1|-140|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|67|17|5|6|7|0|2|18|-15|17|5|6|7|0|9|8|68|14|69|8|70|17|5|6|7|0|3|8|71|14|72|8|73|14|74|8|21|17|5|6|7|0|1|8|73|17|5|6|7|0|1|8|22|14|75|-172|-174|-164|-170|-158|-162|8|76|60|-15|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|-113|8|21|17|5|6|7|0|1|8|57|17|5|6|7|0|1|8|22|14|61|-192|-194|-184|-190|-158|-182|8|34|14|77|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|1565163205|1322849927168|373000000|8|80|14|79|8|40|38|81|1566559026|1322849927168|8|41|14|82|-158|-202|8|43|14|83|8|84|17|5|6|7|0|0|-158|-220|8|21|17|5|6|7|0|1|8|68|17|5|6|7|0|1|8|22|14|85|-226|-228|-158|-224|-154|-156|18|-113|17|5|6|7|0|9|8|68|14|86|8|70|17|5|6|7|0|3|8|71|14|87|8|73|14|74|8|21|17|5|6|7|0|1|8|73|17|5|6|7|0|1|8|22|14|75|-250|-252|-242|-248|-236|-240|8|76|60|-15|8|56|17|5|6|7|0|3|8|57|14|58|8|59|60|-113|8|21|17|5|6|7|0|1|8|57|17|5|6|7|0|1|8|22|14|61|-270|-272|-262|-268|-236|-260|8|34|14|88|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|1565163219|1322849927168|387000000|8|80|14|79|8|40|38|81|1566559037|1322849927168|8|41|14|82|-236|-280|8|43|14|83|8|84|17|5|6|7|0|0|-236|-298|8|21|17|5|6|7|0|1|8|68|17|5|6|7|0|1|8|22|14|89|-304|-306|-236|-302|-154|-234|-150|-152|8|34|14|90|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|1565163203|1322849927168|371000000|8|80|14|79|8|40|38|81|1566559009|1322849927168|8|41|14|82|-150|-314|8|43|14|83|8|91|17|5|6|7|0|0|-150|-332|8|45|14|92|-146|-148|-1|-144|8|93|17|5|6|7|0|2|18|-15|14|94|18|-113|14|95|-1|8|93|8|34|14|96|8|97|17|5|6|7|0|0|-1|-349|8|98|17|5|6|7|0|0|-1|-353|8|99|14|100|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|1565162823|1322849927168|991000000|8|80|14|79|8|40|38|81|1566558902|1322849927168|8|41|14|87|-1|-359|8|101|17|5|6|7|0|2|8|71|14|82|8|73|14|74|-1|-375|8|102|10|11|0|8|103|17|5|6|7|0|0|-1|-386|8|104|10|-385|8|43|14|83|8|105|14|106|8|91|17|5|6|7|0|3|18|-15|14|107|18|-113|14|108|18|19|2|14|109|-1|8|91|8|110|14|111|8|45|14|112|8|84|17|5|6|7|0|2|18|-15|14|113|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|114|-420|-422|-414|-418|-1|-412|8|115|17|5|6|7|0|0|-1|-428|8|116|17|5|6|7|0|0|-1|-432|8|117|17|5|6|7|0|4|8|118|119|120|2|0|8|121|14|121|8|122|14|123|8|124|14|125|-1|-436|8|21|17|5|6|7|0|3|8|105|17|5|6|7|0|1|8|22|14|106|-451|-453|8|13|17|5|6|7|0|1|8|22|14|126|-451|-459|-75|17|5|6|7|0|3|-407|10|-5|-346|10|-5|8|13|10|-5|-451|-75|-1|-449|8|127|17|5|6|7|0|13|8|128|14|129|8|130|14|131|8|34|14|132|8|36|17|5|6|7|0|5|8|78|14|79|8|37|38|39|1565163837|1322849927168|5000000|8|80|14|79|8|40|38|81|1566560108|1322849927168|8|41|14|72|-474|-482|8|133|14|134|8|135|17|5|6|7|0|1|18|-15|14|96|-474|-500|8|136|14|137|8|138|17|5|6|7|0|0|-474|-508|8|139|17|5|6|7|0|0|-474|-512|8|140|14|141|8|43|14|142|8|45|14|143|8|144|14|145|-1|-472|8|146|17|5|6|7|0|1|8|147|17|5|6|7|0|0|-526|-528|-1|-524|0|0|"
      },
      {
        'subst' => 'true',
        :dyn_variables => [
        {"name" => opts[:new_credit_id_dyn_var], "re" => opts[:new_credit_id_var_regexp]}
      ]
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}

    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(10)

    # The next 2 HTTP Requests happen after clicking "Course Requisites" in the left-hand pane
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:pass_fail_dyn_var]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(5)

    # The next HTTP Request happens after clicking "Add Student Eligibility + Prerequisite"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|getReqComponentTypesForStatementType|java.lang.String/2004016611|kuali.statement.type.course.academicReadiness.studentEligibilityPrereq|1|2|3|4|1|5|6|"
      }
    )

    @request.add_thinktime(5)

    # The next 3 HTTP Requests happen after clicking on "Select rule type" dropdown and selecting "Must have successfully completed <course>"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|13|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|translateReqComponentToNL|org.kuali.student.core.statement.dto.ReqComponentInfo/2291374795|java.lang.String/2004016611|org.kuali.student.core.statement.ui.client.widgets.rules.ReqComponentInfoUi/1915746788|org.kuali.student.common.dto.RichTextInfo/1518544421||NEWREQCOMP1000000|kuali.reqComponent.type.course.completed|KUALI.RULE.COMPOSITION|en|1|2|3|4|3|5|6|6|7|0|8|9|9|0|0|10|0|0|0|0|11|12|13|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/MetadataRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|9|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C721122BF64327C2BB379CD5224A091|org.kuali.student.common.ui.client.service.MetadataRpcService|getMetadataList|java.lang.String/2004016611|java.util.List|org.kuali.student.core.statement.dto.ReqCompFieldInfo|java.util.ArrayList/3821976829|kuali.reqComponent.field.type.course.clu.id|1|2|3|4|3|5|6|5|7|8|1|5|9|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CluSetManagementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5BE133251BBD52A0E2D3AED463070079|org.kuali.student.lum.common.client.widgets.CluSetManagementRpcService|getMetadata|java.lang.String/2004016611|java.util.Map|courseSet|1|2|3|4|2|5|6|7|0|"
      }
    )

    @request.add_thinktime(10)

    # The next HTTP Request happens after clicking on "Advanced Search" beneath course and entering "bsci" for Course Code (Subject Code/Number) and then clicking "Search"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|21|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.lang.Integer/3438268394|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lu.queryParam.luOptionalCode|#{advanced_search_code}|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.queryParam.luOptionalState|java.lang.String/2004016611|Active|Approved|Retired|Suspended|lu.search.mostCurrent.union|lu.resultColumn.luOptionalCode|1|2|3|4|1|5|5|6|10|7|0|8|3|9|10|0|11|9|12|0|13|9|14|8|4|15|16|15|17|15|18|15|19|0|20|21|0|6|0|"
      }, {'subst' => 'true',
          :dyn_variables => [
          {"name" => opts[:requisite_ind_dyn_var], "re" => opts[:requisite_ind_var_regexp]}
        ]
      }
    )    

    @request.add_thinktime(5)

    # The next HTTP Request happens after clicking on the row that has Name = "The World of Biology", Code = "BSCI103" and clicking "Select" and then clicking "Add Rule"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|335FF062A700107AB2A642B325C6C5C5|org.kuali.student.lum.program.client.rpc.StatementRpcService|translateReqComponentToNLs|org.kuali.student.core.statement.ui.client.widgets.rules.ReqComponentInfoUi/1915746788|[Ljava.lang.String;/2600011424|java.lang.String/2004016611|org.kuali.student.common.dto.RichTextInfo/1518544421||NEWREQCOMP1000000|java.util.ArrayList/3821976829|org.kuali.student.core.statement.dto.ReqCompFieldInfo/57577190|kuali.reqComponent.field.type.course.clu.id|%%_#{opts[:requisite_ind_dyn_var]}%%|kuali.reqComponent.type.course.completed|KUALI.RULE|KUALI.RULE.PREVIEW|en|1|2|3|4|3|5|6|7|5|0|8|9|9|0|0|10|0|0|11|1|12|0|13|14|0|15|6|2|16|17|18|"
      }, {'subst' => 'true',
          :dyn_variables => [
          {"name" => opts[:required_dyn_var], "re" => opts[:required_var_regexp]}
        ]
      }
    )

    # Click "Save" -- NOTE: Nothing happens -- Is this a bug?

    @request.add_thinktime(5)

    #  Click "Active Dates" in the left-hand pane and a popup appears that reads
    # "Warning
    #  You may have unsaved changes.  Save changes?"
    #  The next HTTP Request happens after clicking "Yes"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|26|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|storeCourseStatements|java.lang.String/2004016611|java.util.Map|%%_#{opts[:pass_fail_dyn_var]}%%|Draft|java.util.HashMap/962170901|java.lang.Integer/3438268394|org.kuali.student.lum.lu.ui.course.client.requirements.CourseRequirementsDataModel$requirementState/1129087124|java.util.LinkedHashMap/1551059846|org.kuali.student.core.statement.dto.StatementTreeViewInfo/1557115098|java.util.ArrayList/3821976829|org.kuali.student.core.statement.ui.client.widgets.rules.ReqComponentInfoUi/1915746788|%%_#{opts[:required_dyn_var]}%%|org.kuali.student.common.dto.RichTextInfo/1518544421||NEWREQCOMP1000000|org.kuali.student.core.statement.dto.ReqCompFieldInfo/57577190|kuali.reqComponent.field.type.course.clu.id|%%_#{opts[:requisite_ind_dyn_var]}%%|kuali.reqComponent.type.course.completed|NEWSTMTTREE9999|org.kuali.student.core.statement.dto.StatementOperatorTypeKey/3804671217|kuali.statement.type.course.academicReadiness.studentEligibilityPrereq|1|2|3|4|4|5|5|6|6|7|8|9|1|10|111111|11|1|12|0|1|-2|13|14|1|15|16|17|18|18|0|0|19|0|16|14|1|20|0|21|22|0|23|14|0|9|0|17|0|18|24|0|0|25|0|0|26|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(5)

    # The next 2 HTTP Requests happen after clicking on the "Start Term" dropdown and clicking on "Spring Semester 2012"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.SP2011-2012|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|6|2|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|19|20|0|0|"
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|23|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|kuali.atp.FA2007-2008|atp.advancedAtpSearchParam.atpEndDateAtpConstraintIdExclusive|kuali.atp.SP2011-2012|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|org.kuali.student.common.search.dto.SortDirection/1734387768|1|2|3|4|1|5|5|0|0|6|3|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|18|7|19|0|20|21|22|23|1|0|"
      }
    )

    @request.add_thinktime(10)

    # The next 4 HTTP Requests happen after clicking "Save"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|156|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|A239E8C5A2EDCD8BCE6061BF191A8095|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|122|courseSpecificLOs|courseTitle|#{new_course_title}|creditOptions|fixedCreditValue|#{new_credit_value}|id|%%_#{opts[:new_credit_id_dyn_var]}%%|metaInfo|createId|#{opts[:modification_person]}|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.util.Date/1659716317|updateId|updateTime|versionInd|0|resultValues|5.0|state|Draft|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|%%_#{opts[:description_dyn_var]}%%#{new_description_addition}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|java.sql.Timestamp/1769758459|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|2|unitsContentOwner|Lecture|kuali.lu.type.activity.Lab|%%_#{opts[:lecture_dyn_var]}%%|Lab|%%_#{opts[:lab_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|Letter|Pass-Fail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|outOfClassHours|1|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{course_code}|kuali.atp.season.Fall|kuali.atp.season.Winter|kuali.atp.season.Spring|Fall|Winter|Spring|transcriptTitle|MICROBES AND SOCIETY|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|Standard final Exam|dirty|startTerm|endTerm|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|4|name|Modify: #{course_title}|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{new_proposal_rationale}|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|collaboratorInfo|collaborators|kuali.atp.SP2011-2012|1|2|3|4|1|5|5|6|7|0|40|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|41|1645031230|1322849927168|8|42|14|38|8|43|40|41|1645031230|1322849927168|8|44|14|45|-43|-49|8|46|17|5|6|7|0|1|18|-15|14|47|-43|-65|8|48|14|49|8|50|14|51|8|21|17|5|6|7|0|1|8|50|17|5|6|7|0|1|8|22|14|52|-77|-79|-43|-75|-39|-41|-1|-37|8|53|17|5|6|7|0|0|-1|-85|8|54|17|5|6|7|0|2|8|55|14|56|8|57|14|58|-1|-89|8|59|17|5|6|7|0|3|8|60|14|61|8|62|63|19|1|8|21|17|5|6|7|0|1|8|60|17|5|6|7|0|1|8|22|14|64|-108|-110|-99|-106|-1|-97|8|65|40|66|3208226304|1185410973696|0|8|67|17|5|6|7|0|1|8|68|17|5|6|7|0|0|-121|-123|-1|-119|8|69|17|5|6|7|0|0|-1|-127|8|70|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|71|17|5|6|7|0|2|18|-15|17|5|6|7|0|9|8|72|14|73|8|74|17|5|6|7|0|3|8|75|14|76|8|77|14|78|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|79|-159|-161|-151|-157|-145|-149|8|80|63|-15|8|59|17|5|6|7|0|3|8|60|14|61|8|62|63|-105|8|21|17|5|6|7|0|1|8|60|17|5|6|7|0|1|8|22|14|64|-179|-181|-171|-177|-145|-169|8|34|14|81|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644953988|1322849927168|156000000|8|42|14|38|8|43|40|41|1645031161|1322849927168|8|44|14|82|-145|-189|8|48|14|49|8|83|17|5|6|7|0|0|-145|-207|8|21|17|5|6|7|0|1|8|72|17|5|6|7|0|1|8|22|14|84|-213|-215|-145|-211|-141|-143|18|-105|17|5|6|7|0|9|8|72|14|85|8|74|17|5|6|7|0|3|8|75|14|82|8|77|14|78|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|79|-237|-239|-229|-235|-223|-227|8|80|63|-15|8|59|17|5|6|7|0|3|8|60|14|61|8|62|63|-105|8|21|17|5|6|7|0|1|8|60|17|5|6|7|0|1|8|22|14|64|-257|-259|-249|-255|-223|-247|8|34|14|86|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644954002|1322849927168|170000000|8|42|14|38|8|43|40|41|1645031210|1322849927168|8|44|14|82|-223|-267|8|48|14|49|8|83|17|5|6|7|0|0|-223|-285|8|21|17|5|6|7|0|1|8|72|17|5|6|7|0|1|8|22|14|87|-291|-293|-223|-289|-141|-221|-137|-139|8|34|14|88|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644953985|1322849927168|153000000|8|42|14|38|8|43|40|41|1645031149|1322849927168|8|44|14|82|-137|-301|8|48|14|49|8|89|17|5|6|7|0|0|-137|-319|8|50|14|90|-133|-135|-1|-131|8|91|17|5|6|7|0|3|18|-15|14|92|18|-105|14|93|8|21|17|5|6|7|0|2|18|-15|17|5|6|7|0|1|8|22|14|94|-335|-337|18|-105|17|5|6|7|0|1|8|22|14|95|-335|-343|-327|-333|-1|-325|8|34|14|96|8|97|17|5|6|7|0|0|-1|-351|8|98|17|5|6|7|0|0|-1|-355|8|99|14|100|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644953677|1322849927168|845000000|8|42|14|38|8|43|40|41|1645031116|1322849927168|8|44|14|76|-1|-361|8|101|17|5|6|7|0|2|8|75|14|102|8|77|14|78|-1|-377|8|103|10|11|0|8|104|17|5|6|7|0|0|-1|-388|8|105|10|-387|8|48|14|49|8|106|14|107|8|89|17|5|6|7|0|4|18|-15|14|108|18|-105|14|109|18|19|2|14|110|8|21|17|5|6|7|0|3|18|-15|17|5|6|7|0|1|8|22|14|111|-411|-413|18|-105|17|5|6|7|0|1|8|22|14|112|-411|-419|18|-407|17|5|6|7|0|1|8|22|14|113|-411|-425|-400|-409|-1|-398|8|114|14|115|8|50|14|116|8|83|17|5|6|7|0|2|18|-15|14|117|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|118|-443|-445|-437|-441|-1|-435|8|119|17|5|6|7|0|0|-1|-451|8|120|17|5|6|7|0|0|-1|-455|8|121|17|5|6|7|0|4|8|122|123|124|2|0|8|125|14|125|8|126|14|127|8|128|14|129|-1|-459|8|21|17|5|6|7|0|3|8|106|17|5|6|7|0|1|8|22|14|107|-474|-476|8|13|17|5|6|7|0|1|8|22|14|130|-474|-482|8|131|17|5|6|7|0|2|8|132|10|-5|8|133|10|-5|-474|-488|-1|-472|8|134|17|5|6|7|0|13|8|135|14|136|8|137|14|138|8|34|14|139|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644954426|1322849927168|594000000|8|42|14|38|8|43|40|41|1645032120|1322849927168|8|44|14|140|-498|-506|8|141|14|142|8|143|17|5|6|7|0|1|18|-15|14|96|-498|-524|8|144|14|145|8|146|17|5|6|7|0|0|-498|-532|8|147|17|5|6|7|0|0|-498|-536|8|148|14|149|8|48|14|150|8|50|14|151|8|152|14|153|-1|-496|8|154|17|5|6|7|0|1|8|155|17|5|6|7|0|0|-550|-552|-1|-548|-492|14|156|-494|14|0|0|0|"
      }, {'subst' => 'true',
          :dyn_variables => [
          {"name" => opts[:new_active_date_dyn_var], "re" => opts[:new_active_date_var_regexp]}
        ]
      }
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(5)

    # The next 5 HTTP Requests happen after clicking "Review Proposal" in the left-hand pane
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5771428875B68D3E8EC7527EC8D18D40|org.kuali.student.core.document.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:preRoute_dyn_var]}%%|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|155|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C9BBAD14113E13A72476EEE8100687B|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|validate|org.kuali.student.common.assembly.data.Data/3184510345|org.kuali.student.common.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.common.assembly.data.Data$StringKey/758802082|passFail|org.kuali.student.common.assembly.data.Data$BooleanValue/4261226833|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.common.assembly.data.Data$StringValue/3151113388|STD|campusLocations|org.kuali.student.common.assembly.data.Data$DataValue/1692468409|org.kuali.student.common.assembly.data.Data$IntegerKey/134469241|java.lang.Integer/3438268394|NO|_runtimeData|id-translation|North|code|#{course_number}|courseNumberSuffix|122|courseSpecificLOs|courseTitle|#{new_course_title}|creditOptions|fixedCreditValue|#{new_credit_value}|id|%%_#{opts[:new_credit_id_dyn_var]}%%|metaInfo|createId|#{opts[:modification_person]}|createTime|org.kuali.student.common.assembly.data.Data$DateValue/2929953165|java.util.Date/1659716317|updateId|updateTime|versionInd|0|resultValues|5.0|state|Draft|type|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|formatted|%%_#{opts[:description_dyn_var]}%%|plain|%%_#{opts[:description_dyn_var]}%%#{new_description_addition}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.common.assembly.data.Data$IntegerValue/3605481012|Semester|effectiveDate|java.sql.Timestamp/1769758459|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lecture|contactHours|unitQuantity|3|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|%%_#{opts[:defaultEnrollmentEstimate_dyn_var]}%%|unitsContentOwner|Lecture|kuali.lu.type.activity.Lab|2|%%_#{opts[:lecture_dyn_var]}%%|Lab|%%_#{opts[:lab_dyn_var]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|Letter|Pass-Fail|%%_#{opts[:pass_fail_dyn_var]}%%|instructors|joints|level|100|4|outOfClassHours|1|pilotCourse|revenues|specialTopicsCourse|startTerm|kuali.atp.SP2011-2012|subjectArea|#{course_code}|kuali.atp.season.Fall|kuali.atp.season.Winter|kuali.atp.season.Spring|Fall|Winter|Spring|transcriptTitle|MICROBES AND SOCIETY|kuali.lu.type.CreditCourse|65|Biology Dept|unitsDeployment|variations|versionInfo|sequenceNumber|org.kuali.student.common.assembly.data.Data$LongValue/3784756947|java.lang.Long/4227064769|versionComment|versionIndId|%%_#{opts[:course_ind_dyn_var]}%%|versionedFromId|%%_#{opts[:course_name_dyn_var]}%%|%%_#{opts[:new_active_date_dyn_var]}%%|Standard final Exam|proposal|prevStartTerm|kuali.atp.FA2007-2008|workflowNode|PreRoute|%%_#{opts[:preRoute_dyn_var]}%%|name|Modify: #{course_title}|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{new_proposal_rationale}|Saved|kuali.proposal.type.course.modify|workflowId|%%_#{opts[:workflowId_dyn_var]}%%|collaboratorInfo|collaborators|1|2|3|4|1|5|5|6|7|0|39|8|9|10|11|1|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|0|-1|-31|8|29|14|30|8|31|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|32|14|33|8|34|14|35|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|41|1645031230|1322849927168|8|42|14|38|8|43|40|41|1645031230|1322849927168|8|44|14|45|-43|-49|8|46|17|5|6|7|0|1|18|-15|14|47|-43|-65|8|48|14|49|8|50|14|51|8|21|17|5|6|7|0|1|8|50|17|5|6|7|0|1|8|22|14|52|-77|-79|-43|-75|-39|-41|-1|-37|8|53|17|5|6|7|0|0|-1|-85|8|54|17|5|6|7|0|2|8|55|14|56|8|57|14|58|-1|-89|8|59|17|5|6|7|0|3|8|60|14|61|8|62|63|19|1|8|21|17|5|6|7|0|1|8|60|17|5|6|7|0|1|8|22|14|64|-108|-110|-99|-106|-1|-97|8|65|40|66|927505536|1327144894464|0|8|67|17|5|6|7|0|1|8|68|17|5|6|7|0|0|-121|-123|-1|-119|8|69|17|5|6|7|0|0|-1|-127|8|70|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|71|17|5|6|7|0|2|18|-15|17|5|6|7|0|9|8|72|14|73|8|74|17|5|6|7|0|3|8|75|14|76|8|77|14|78|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|79|-159|-161|-151|-157|-145|-149|8|80|63|-15|8|59|17|5|6|7|0|3|8|60|14|61|8|62|63|-105|8|21|17|5|6|7|0|1|8|60|17|5|6|7|0|1|8|22|14|64|-179|-181|-171|-177|-145|-169|8|34|14|81|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644953988|1322849927168|156000000|8|42|14|38|8|43|40|41|1646825117|1322849927168|8|44|14|76|-145|-189|8|48|14|49|8|82|17|5|6|7|0|0|-145|-207|8|21|17|5|6|7|0|1|8|72|17|5|6|7|0|1|8|22|14|83|-213|-215|-145|-211|-141|-143|18|-105|17|5|6|7|0|9|8|72|14|84|8|74|17|5|6|7|0|3|8|75|14|85|8|77|14|78|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|79|-237|-239|-229|-235|-223|-227|8|80|63|-15|8|59|17|5|6|7|0|3|8|60|14|61|8|62|63|-105|8|21|17|5|6|7|0|1|8|60|17|5|6|7|0|1|8|22|14|64|-257|-259|-249|-255|-223|-247|8|34|14|86|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644954002|1322849927168|170000000|8|42|14|38|8|43|40|41|1646825127|1322849927168|8|44|14|76|-223|-267|8|48|14|49|8|82|17|5|6|7|0|0|-223|-285|8|21|17|5|6|7|0|1|8|72|17|5|6|7|0|1|8|22|14|87|-291|-293|-223|-289|-141|-221|-137|-139|8|34|14|88|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644953985|1322849927168|153000000|8|42|14|38|8|43|40|41|1646825099|1322849927168|8|44|14|76|-137|-301|8|48|14|49|8|89|17|5|6|7|0|0|-137|-319|8|50|14|90|-133|-135|-1|-131|8|91|17|5|6|7|0|3|18|-15|14|92|18|-105|14|93|8|21|17|5|6|7|0|2|18|-15|17|5|6|7|0|1|8|22|14|94|-335|-337|18|-105|17|5|6|7|0|1|8|22|14|95|-335|-343|-327|-333|-1|-325|8|34|14|96|8|97|17|5|6|7|0|0|-1|-351|8|98|17|5|6|7|0|0|-1|-355|8|99|14|100|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644953677|1322849927168|845000000|8|42|14|38|8|43|40|41|1646825064|1322849927168|8|44|14|101|-1|-361|8|102|17|5|6|7|0|2|8|75|14|103|8|77|14|78|-1|-377|8|104|10|11|0|8|105|17|5|6|7|0|0|-1|-388|8|106|10|-387|8|107|14|108|8|48|14|49|8|109|14|110|8|89|17|5|6|7|0|4|18|-15|14|111|18|-105|14|112|18|19|2|14|113|8|21|17|5|6|7|0|3|18|-15|17|5|6|7|0|1|8|22|14|114|-413|-415|18|-105|17|5|6|7|0|1|8|22|14|115|-413|-421|18|-409|17|5|6|7|0|1|8|22|14|116|-413|-427|-402|-411|-1|-400|8|117|14|118|8|50|14|119|8|82|17|5|6|7|0|2|18|-15|14|120|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|121|-445|-447|-439|-443|-1|-437|8|122|17|5|6|7|0|0|-1|-453|8|123|17|5|6|7|0|0|-1|-457|8|124|17|5|6|7|0|4|8|125|126|127|2|0|8|128|14|128|8|129|14|130|8|131|14|132|-1|-461|8|21|17|5|6|7|0|3|8|107|17|5|6|7|0|1|8|22|14|133|-476|-478|8|109|17|5|6|7|0|1|8|22|14|110|-476|-484|8|13|17|5|6|7|0|1|8|22|14|134|-476|-490|-1|-474|8|135|17|5|6|7|0|13|8|136|14|137|8|138|14|139|8|34|14|140|8|36|17|5|6|7|0|5|8|37|14|38|8|39|40|66|1644954426|1322849927168|594000000|8|42|14|38|8|43|40|41|1646826013|1322849927168|8|44|14|33|-498|-506|8|141|14|142|8|143|17|5|6|7|0|1|18|-15|14|96|-498|-524|8|144|14|145|8|146|17|5|6|7|0|0|-498|-532|8|147|17|5|6|7|0|0|-498|-536|8|148|14|149|8|48|14|150|8|50|14|151|8|152|14|153|-1|-496|8|154|17|5|6|7|0|1|8|155|17|5|6|7|0|0|-550|-552|-1|-548|0|0|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(10)

    # The next 4 HTTP Requests happen after clicking in the "Proposal Actions" dropdown and clicking "Cancel Proposal" and then clicking "Yes, cancel proposal"
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|cancelDocumentWithId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|71417C94A72A0CF76A43A2B36B8E3E1B|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|12BDE6C2DA6A7CF74BE0FBF074E806E1|org.kuali.student.core.proposal.ui.client.service.ProposalRpcService|getProposalByWorkflowId|java.lang.String/2004016611|%%_#{opts[:workflowId_dyn_var]}%%|1|2|3|4|1|5|6|"
      }, {'subst' => 'true'}
    )

    @request.add_thinktime(5)

  end
end