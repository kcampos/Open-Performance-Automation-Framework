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
      :propose_person => '%%_username%%', #user the dynvar from users.csv
      :mode => 'blank',
      :nav_homepage => true,
      :submit => true,
      :append_unique_id => false, #tell tsung to append unique id on title
      :instructor => 'fred', #BUG - HARDCODED - can't use dynvar though because of ajax search
      :collaborator => @request.config.directory["users"]["collaborator"]["username"],
      :first_expected_offering => @request.config.directory["atp"]["name"],
      :subject_area => "ARTS",
      :course_suffix => "123",
      :course_short_title => "Perf Course",
      :course_title => title,
      :course_description => "My fake description.",
      :course_rationale => "My fake rationale.",
      :lo_create => FALSE,
      :lo_category => lo_cat,
      :lo_cat_text => lo_cat_text,
      :lo_name => @request.config.directory["lo"]["name"],
      :admin_dep_var_name => "admin_dep_org_id",
      :admin_dep_var_regexp => 'org.resultColumn.orgId\"\,\"\([^\"]+\)',
      :proposal_dyn_var_name => "proposal_id",
      :proposal_dyn_var_regexp => '\"proposal\"\,\"\([^\"]+\)',
      :proposal_doc_id_var_name => "proposal_doc_id",
      :proposal_doc_id_var_regexp => 'workflowId\"\,\"\([^\"]+\)\"',
      :clu_ref_dyn_var_name => "clu_ref_id",
      :clu_ref_dyn_var_regexp => '\"id\"\,\"\([^\"]+\)',
      :result_com_var_name => "result_component_id",
      :result_com_var_regexp => '\"ResultComponent 1\"\,\"\([^\"]+\)',
      :enroll_est_var_name => "default_enrollment_estimate_id",
      :enroll_est_var_regexp => 'defaultEnrollmentEstimate\"\,\"kuali.atp.duration.Week\"\,\"Week\"\,\"\([^\"]+\)',
      :lab_var_name => "lab_id",
      :lab_var_regexp => 'draft\"\,\"unitsContentOwner\"\,\"Lab\"\,\"\([^\"]+\)',
      :lab_fee_id_name => 'cp_lab_fee_id',
      :lab_fee_id_regexp => 'kuali.enum.type.feeTypes.labFee\"\,\"\([^\"]+\)',
      :revenues_id_name => 'cp_revenues_id',
      :revenues_id_regexp => 'revenues\"\,\"\([^\"]+\)',
      :revenue_id_name => 'cp_revenue_id',
      :revenue_id_regexp => 'REVENUE\"\,\"\([^\"]+\)',
      :joints_var_name => "joints_num",
      :joints_var_regexp => 'joints\"\,\"[^\"]+\"\,\"\([^\"]+\)',
      :fee_info_id_dyn_var_name => 'fee_info_id',
      :fee_info_id_dyn_var_regexp => '\"fees\"\,\"\([^\"]+\)',
      :fee_info_dyn_var_name => 'fee_info',
      :fee_info_dyn_var_regexp => 'org.kuali.student.lum.lu.dto.CluFeeInfo\"\,\"\([^\"]+\)',
      :clu_info_dyn_var_name => 'clu_info',
      :clu_info_dyn_var_regexp => 'org.kuali.student.lum.lu.dto.CluInfo\"\,\"\([^\"]+\)',
      :lu_dto_clu_format_dyn_var_name => "lu_dto_clu_format",
      :lu_dto_clu_format_dyn_var_regexp => 'org.kuali.student.lum.lu.dto.CluInfo\"\,\"Credit Course\"\,\"[^\"]+\"\,\"formats\"\,\"\([^\"]+\)',
      :lu_dto_clu_activities_dyn_var_name => "lu_dto_clu_activites",
      :lu_dto_clu_activities_dyn_var_regexp => 'org.kuali.student.lum.lu.dto.CluInfo\"\,\"Credit Course\"\,\"[^\"]+\"\,\"formats\"\,\"[^\"]+\"\,\"0\"\,\"activities\"\,\"\([^\"]+\)',
      :outcome_id_var_name => "outcome_id",
      :outcome_id_var_regexp => 'outcomeId\"\,\"\([^\"]+\)',
      :lo_category_var_name => "lo_category",
      #:lo_category_var_regexp => lo_cat_text + '\"\,\"plain\"\,\"id\"\,\"\([^\"]+\)',
      :lo_category_var_regexp => lo_cat_text + '\"\,\"plain\"\,\"\([^\"]+\)',
      :lo_category_id_var_name => "lo_category_id",
      :lo_category_id_var_regexp => 'lo.resultColumn.categoryId"\,\"\([^\"]+\)',
      :lo_child_id_dyn_var_name => "lo_child_id",
      :lo_child_id_dyn_var_regexp => 'childLo\"\,\"\([^\"]+\)',
      :single_use_lo_dyn_var_name => "single_use_lo",
      :single_use_lo_dyn_var_regexp => 'includedSingleUseLo\"\,\"\([^\"]+\)',
      :atp_duration_week_var_name => 'atp_duration_week',
      :atp_duration_week_var_regexp => 'kuali.atp.duration.Week\"\,\"Week\"\,\"\([^\"]+\)',
      :version_ind_id_name => 'cp_version_ind_id',
      :version_ind_id_regexp => 'versionIndId\"\,\"\([^\"]+\)',
      :affliated_orgs_id_name => 'cp_affiliated_orgs_id',
      :affliated_orgs_id_regexp => 'affiliatedOrgs\"\,\"\([^\"]+\)'
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
    
    # Create a course
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:propose_person]}|useCurriculumReview|1|2|3|4|2|5|5|6|7|"
      }, {'subst' => 'true'}
    )
    
    
    # Click Start blank proposal
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|15|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|D60D3C6E0D395C18A0F44A2D9D2A7348|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|getMetadata|java.lang.String/2004016611|java.util.Map||java.util.HashMap/962170901|documentTypeName|kuali.proposal.type.course.create|DtoState|Draft|DtoNextState|DtoWorkflowNode|PreRoute|1|2|3|4|2|5|6|7|8|4|5|9|5|10|5|11|5|12|5|13|5|7|5|14|5|15|"
      }
    )
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|2543249A07E7952228E0E500F14F1B17|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
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
        'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|atp.search.atpSeasonTypes|atp.resultColumn.atpSeasonTypeName|1|2|3|4|1|5|5|0|0|6|0|7|8|0|0|"
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
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|lrc.queryParam.resultComponent.type|kuali.resultComponentType.grade.finalGrade|lrc.queryParam.resultComponent.idRestrictionList|java.lang.String/2004016611|kuali.resultComponent.grade.letter|kuali.resultComponent.grade.passFail|kuali.resultComponent.grade.satisfactory|kuali.resultComponent.grade.completedNotation|kuali.resultComponent.grade.percentage|lrc.search.resultComponent|lrc.resultColumn.resultComponent.id|1|2|3|4|1|5|5|0|0|6|2|7|8|0|9|7|10|6|5|11|12|11|13|11|14|11|15|11|16|0|17|18|0|0|"
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
        'contents' => "5|0|18|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|6|1|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|17|18|0|0|"
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
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CommentRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|58FCBA6F511FF769D9DF8CAE72C3C369|org.kuali.student.core.comments.ui.client.service.CommentRpcService|getUserRealName|java.lang.String/2004016611|#{opts[:propose_person]}|1|2|3|4|1|5|6|"
      },
      {
        'subst' => 'true'
      }
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
        'contents' => "5|0|19|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|DB85114A8D2B33860498043707FB831D|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.common.search.dto.SearchRequest/2597477947|java.util.ArrayList/3821976829|org.kuali.student.common.search.dto.SearchParam/1222427352|atp.advancedAtpSearchParam.atpType|java.lang.String/2004016611|kuali.atp.type.Spring|kuali.atp.type.Summer|kuali.atp.type.Fall|kuali.atp.type.Session1|kuali.atp.type.Session2|kuali.atp.type.Mini-mester1A|kuali.atp.type.Mini-mester1B|atp.advancedAtpSearchParam.atpStartDateAtpConstraintId|atp.search.advancedAtpSearch|atp.resultColumn.atpStartDate|1|2|3|4|1|5|5|0|0|6|2|7|8|6|7|9|10|9|11|9|12|9|13|9|14|9|15|9|16|0|7|17|0|0|18|19|0|0|"
      }
    )
        
    
  end
  
  def scratch

      
      


      


      #
      # Pg1 - Course Information
      #

      @request.add_thinktime(5)

      # Course Subject Area
      # AJAX popup while typing in subject area
      for i in 1..opts[:subject_area].length
        itr = i-1
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|enumeration.queryParam.enumerationOptionalCode|#{opts[:subject_area][0..itr]}|enumeration.queryParam.enumerationType|kuali.lu.subjectArea|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|6|0|7|2|8|9|0|10|8|11|0|12|13|14|0|0|"
          }                             
        )        
      end

      @request.add_thinktime(3)

      # Instructor
      for i in 1..opts[:instructor].length
        itr = i-1
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|person.queryParam.personGivenName|#{opts[:instructor][0..itr]}|person.search.personQuickViewByGivenName|person.resultColumn.DisplayName|1|2|3|4|1|5|5|0|6|0|7|1|8|9|0|10|11|12|0|0|"
          }                             
        )        
      end


      @request.add_thinktime(22)

      # Save & Continue
      contents1 = "5|0|37|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AC353D4ABD03D7D33CA737138E10D96B|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|proposal|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|name|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|#{title}|_runtimeData|dirty|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|rationale|#{opts[:course_rationale]}|courseTitle|#{opts[:course_title]}|transcriptTitle|subjectArea|courseNumberSuffix|instructors|#{opts[:course_short_title]}|#{opts[:subject_area]}|#{opts[:course_suffix]}|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|personId|#{opts[:instructor]}|id-translation|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|descr|plain|#{opts[:course_description]}"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|8|8|9|10|5|6|7|0|3|8|11|12|13|8|14|10|5|6|7|0|1|8|15|10|5|6|7|0|2|-7|16|17|1|8|18|16|-18|-11|-13|-5|-9|-19|12|19|-1|-3|8|20|12|21|-9|10|5|6|7|0|1|-13|10|5|6|7|0|5|-22|16|-18|8|22|16|-18|8|23|16|-18|8|24|16|-18|8|25|16|-18|-25|-13|-1|-9|-31|12|26|-33|12|27|-35|12|28|-37|10|5|6|7|0|1|29|30|0|10|5|6|7|0|2|8|31|12|32|8|14|10|5|6|7|0|1|8|31|10|5|6|7|0|1|8|33|12|34|-54|-56|-48|-52|-43|-45|-1|8|25|8|35|10|5|6|7|0|2|8|36|12|37|-9|10|5|6|7|0|1|-13|10|5|6|7|0|1|-67|16|-18|-70|-13|-65|-9|-1|-63|0|0|"
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "#{contents1}#{contents2}"
        },
        {
          :dyn_variables => [
            {"name" => opts[:proposal_dyn_var_name], "regexp" => opts[:proposal_dyn_var_regexp]},
            {"name" => opts[:clu_ref_dyn_var_name], "regexp" => opts[:clu_ref_dyn_var_regexp]},
            {"name" => opts[:proposal_doc_id_var_name], "regexp" => opts[:proposal_doc_id_var_regexp]},
            {"name" => opts[:version_ind_id_name], "regexp" => opts[:version_ind_id_regexp]}
          ]
        }
      )

      #@request.add("DEBUG/proposal_dyn_var_name/%%_#{opts[:proposal_dyn_var_name]}%%", {}, {'subst' => 'true'})
      #@request.add("DEBUG/clu_ref_dyn_var_name/%%_#{opts[:clu_ref_dyn_var_name]}%%", {}, {'subst' => 'true'})
      #@request.add("DEBUG/proposal_doc_id_var_name/%%_#{opts[:proposal_doc_id_var_name]}%%", {}, {'subst' => 'true'})
      #@request.add("DEBUG/version_ind_id_name/%%_#{opts[:version_ind_id_name]}%%", {}, {'subst' => 'true'})


      #
      # Governance
      # Campus Locations: All

      @request.add_thinktime(5)

      # COC Org
      for i in 1..oversight_department.length
        itr = i-1
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalLongName|#{oversight_department[0..itr]}|org.queryParam.orgOptionalType|java.lang.String/2004016611|kuali.org.Department|kuali.org.College|org.search.generic||1|2|3|4|1|5|5|0|6|0|7|2|8|9|0|10|8|11|7|2|12|13|12|14|0|15|16|0|0|"
          }                             
        )        
      end

      @request.add_thinktime(3)

      # Admin Org
      for i in 1..admin_org.length
        itr = i-1
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalLongName|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|java.lang.String/2004016611|kuali.org.Department|kuali.org.College|org.search.generic||1|2|3|4|1|5|5|0|6|0|7|2|8|9|0|10|8|11|7|2|12|13|12|14|0|15|16|0|0|"
          }    
        )    
      end

      @request.add_thinktime(15)

      # Save & Continue
      contents1 = "5|0|98|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AC353D4ABD03D7D33CA737138E10D96B|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|campusLocations|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|AL|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|courseTitle|#{opts[:course_title]}|creditOptions|crossListings|descr|plain|#{opts[:course_description]}|expenditure|affiliatedOrgs|fees|formats|gradingOptions|id|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|_runtimeData|id-translation|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|metaInfo|createId|#{opts[:propose_person]}|createTime|org.kuali.student.core.assembly.data.Data$DateValue/3833457837|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|#{version_indicator+=1}|pilotCourse|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|revenues|specialTopicsCourse|state|draft|subjectArea|#{opts[:subject_area]}|termsOffered|transcriptTitle|#{opts[:course_short_title]}|type|kuali.lu.type.CreditCourse|unitsContentOwner|58|#{oversight_department}|unitsDeployment|28|#{admin_org}|variations|versionInfo|currentVersionStart|sequenceNumber|org.kuali.student.core.assembly.data.Data$LongValue/2873666547|java.lang.Long/4227064769|versionIndId|%%_#{opts[:version_ind_id_name]}%%|dirty|proposal|%%_#{opts[:proposal_dyn_var_name]}%%|2|name|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|32|8|9|10|5|6|7|0|1|11|12|0|13|14|-1|8|9|8|15|13|16|8|17|13|18|8|19|10|5|6|7|0|0|-1|-15|8|20|13|21|8|22|10|5|6|7|0|0|-1|-21|8|23|10|5|6|7|0|0|-1|-25|8|24|10|5|6|7|0|1|8|25|13|26|-1|-29|8|27|10|5|6|7|0|1|8|28|10|5|6|7|0|0|-37|-39|-1|-35|8|29|10|5|6|7|0|0|-1|-43|8|30|10|5|6|7|0|0|-1|-47|8|31|10|5|6|7|0|0|-1|-51|8|32|13|33|8|34|10|5|6|7|0|1|11|-8|10|5|6|7|0|2|8|35|13|36|8|37|10|5|6|7|0|1|8|35|10|5|6|7|0|1|8|38|13|39|-69|-71|-63|-67|-59|-61|-1|-57|8|40|10|5|6|7|0|0|-1|-77|8|41|13|42|8|43|10|5|6|7|0|5|8|44|13|45|8|46|47|48|284332964|1297080123392|356000000|8|49|13|45|8|50|47|48|284332964|1297080123392|356000000|8|51|13|52|-1|-83|8|53|54|55|0|8|56|10|5|6|7|0|0|-1|-102|8|57|54|-101|8|58|13|59|8|60|13|61|8|62|10|5|6|7|0|0|-1|-112|8|63|13|64|8|65|13|66|8|67|10|5|6|7|0|2|11|-8|13|68|8|37|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|38|13|69|-128|-130|-122|-126|-1|8|67|8|70|10|5|6|7|0|2|11|-8|13|71|8|37|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|38|13|72|-145|-147|-139|-143|-1|8|70|8|73|10|5|6|7|0|0|-1|-154|8|74|10|5|6|7|0|3|8|75|47|48|284332964|1297080123392|356000000|8|76|77|78|1|0|8|79|13|80|-1|-158|8|37|10|5|6|7|0|2|8|60|10|5|6|7|0|1|8|38|13|61|-172|-174|8|81|10|5|6|7|0|3|8|9|54|55|1|8|67|54|-186|8|70|54|-186|-172|-180|-1|-170|8|82|10|5|6|7|0|11|8|32|13|83|8|43|10|5|6|7|0|5|8|44|13|45|8|46|47|48|284333087|1297080123392|479000000|8|49|13|45|8|50|47|48|284334143|1297080123392|535000000|8|51|13|84|-193|-197|8|85|13|21|8|86|10|5|6|7|0|1|11|-8|13|33|-193|-215|8|87|13|88|8|89|10|5|6|7|0|0|-193|-223|8|90|10|5|6|7|0|0|-193|-227|8|91|13|92|8|58|13|93|8|65|13|94|8|95|13|96|-1|-191|8|97|10|5|6|7|0|1|8|98|10|5|6|7|0|0|-241|-243|-1|-239|0|0|"
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


      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|lu.queryParam.luOptionalLuTypeStartsWith|kuali.lu.type.activity.|lu.search.all.lu.Types|lu.resultColumn.luTypeName|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|enumeration.queryParam.enumerationType|kuali.atptype.duration|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
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
      contents1 = "5|0|124|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AC353D4ABD03D7D33CA737138E10D96B|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|campusLocations|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|courseTitle|#{opts[:course_title]}|creditOptions|dirty|type|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|fixedCreditValue|created|kuali.resultComponentType.credit.degree.fixed|10|crossListings|descr|plain|#{opts[:course_description]}|expenditure|affiliatedOrgs|fees|formats|activities|activityType|defaultEnrollmentEstimate|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitType|kuali.atp.duration.week|duration|atpDurationTypeKey|timeQuantity|kuali.atp.duration.Week|org.kuali.student.core.assembly.data.Data$IntegerValue/991919491|gradingOptions|kuali.resultComponent.grade.letter|id|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|metaInfo|createId|#{opts[:propose_person]}|createTime|org.kuali.student.core.assembly.data.Data$DateValue/3833457837|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|#{version_indicator+=1}|pilotCourse|revenues|specialTopicsCourse|state|draft|subjectArea|#{opts[:subject_area]}|termsOffered|kuali.atp.season.Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|unitsContentOwner|58|#{oversight_department}|unitsDeployment|28|#{admin_org}|variations|versionInfo|currentVersionStart|sequenceNumber|org.kuali.student.core.assembly.data.Data$LongValue/2873666547|java.lang.Long/4227064769|versionIndId|%%_#{opts[:version_ind_id_name]}%%|finalExamStatus|audit|passFail|proposal|%%_#{opts[:proposal_dyn_var_name]}%%|3|name|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators|kuali.atp.duration.Semester|STD"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|36|8|9|10|5|6|7|0|2|11|12|0|13|14|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|17|-12|-14|-5|-10|-1|-3|8|18|13|19|8|20|13|21|8|22|10|5|6|7|0|0|-1|-24|8|23|13|24|8|25|10|5|6|7|0|1|11|-8|10|5|6|7|0|3|8|15|10|5|6|7|0|3|8|26|10|5|6|7|0|2|8|27|28|29|1|8|30|28|-48|-40|-42|8|31|28|-48|-38|10|5|6|7|0|1|-42|10|5|6|7|0|1|-51|28|-48|-54|-42|-40|-38|-36|-38|-46|13|32|-49|13|33|-32|-34|-1|-30|8|34|10|5|6|7|0|0|-1|-62|8|35|10|5|6|7|0|1|8|36|13|37|-1|-66|8|38|10|5|6|7|0|1|8|39|10|5|6|7|0|0|-74|-76|-1|-72|8|40|10|5|6|7|0|0|-1|-80|8|41|10|5|6|7|0|1|11|-8|10|5|6|7|0|2|8|42|10|5|6|7|0|1|11|-8|10|5|6|7|0|5|-38|10|5|6|7|0|3|-42|10|5|6|7|0|2|8|43|28|-48|8|44|28|-48|-101|-42|8|31|28|-48|-38|10|5|6|7|0|1|-42|10|5|6|7|0|1|-110|28|-48|-113|-42|-101|-38|-98|-38|-106|13|45|8|46|10|5|6|7|0|3|8|47|13|48|-38|10|5|6|7|0|1|-42|10|5|6|7|0|2|-124|28|-48|8|49|28|-48|-127|-42|-122|-38|-133|13|50|-98|-120|8|51|10|5|6|7|0|3|-38|10|5|6|7|0|1|-42|10|5|6|7|0|2|8|52|28|-48|8|53|28|-48|-141|-42|-138|-38|-146|13|54|-148|55|12|13|-98|-136|-108|55|12|100|-94|-96|-90|-92|8|15|10|5|6|7|0|2|8|31|28|-48|-38|10|5|6|7|0|1|-42|10|5|6|7|0|1|-159|28|-48|-162|-42|-157|-38|-90|-155|-86|-88|-1|-84|8|56|10|5|6|7|0|1|11|-8|13|57|-1|8|56|8|58|13|59|8|60|10|5|6|7|0|1|11|-8|10|5|6|7|0|2|8|61|13|62|8|15|10|5|6|7|0|1|8|61|10|5|6|7|0|1|8|16|13|63|-189|-191|-183|-187|-179|-181|-1|-177|8|64|10|5|6|7|0|0|-1|-197|8|65|13|66|8|67|10|5|6|7|0|5|8|68|13|69|8|70|71|72|284949347|1297080123392|739000000|8|73|13|69|8|74|71|72|284956132|1297080123392|524000000|8|75|13|76|-1|-203|8|77|28|29|0|8|78|10|5|6|7|0|0|-1|-222|8|79|28|-221|8|80|13|81|8|82|13|83|8|84|10|5|6|7|0|1|11|-8|13|85|-1|8|84|8|86|13|87|8|27|13|88|8|89|10|5|6|7|0|2|11|-8|13|90|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|91|-251|-253|-245|-249|-1|-243|8|92|10|5|6|7|0|2|11|-8|13|93|8|15|10|5|6|7|0|1|11|-8|10|5|6|7|0|1|8|16|13|94|-267|-269|-261|-265|-1|-259|8|95|10|5|6|7|0|0|-1|-275|8|96|10|5|6|7|0|3|8|97|71|72|284949346|1297080123392|738000000|8|98|99|100|1|0|8|101|13|102|-1|-279|8|15|10|5|6|7|0|2|8|82|10|5|6|7|0|1|8|16|13|83|-293|-295|-42|10|5|6|7|0|5|8|84|28|-48|8|56|28|-48|8|103|28|-48|8|104|28|-48|8|105|28|-48|-293|-42|-1|-291|8|106|10|5|6|7|0|11|8|58|13|107|8|67|10|5|6|7|0|5|8|68|13|69|8|70|71|72|284949501|1297080123392|893000000|8|73|13|69|8|74|71|72|284957084|1297080123392|476000000|8|75|13|108|-316|-320|8|109|13|24|8|110|10|5|6|7|0|1|11|-8|13|59|-316|-338|8|111|13|112|8|113|10|5|6|7|0|0|-316|-346|8|114|10|5|6|7|0|0|-316|-350|8|115|13|116|8|80|13|117|8|27|13|118|8|119|13|120|-1|-314|8|121|10|5|6|7|0|1|8|122|10|5|6|7|0|0|-364|-366|-1|-362|8|51|10|5|6|7|0|3|-38|10|5|6|7|0|1|-42|10|5|6|7|0|2|8|52|28|-48|8|53|28|-48|-375|-42|-372|-38|-380|13|123|-382|55|12|2|-1|-370|-308|13|124|-310|28|-221|-312|28|-221|0|0|"
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
       {
         'method' => 'POST',
         'content_type' => 'text/x-gwt-rpc; charset=utf-8',
         'contents' => "#{contents1}#{contents2}"
       },
       {
         'subst' => 'true',
         :dyn_variables => [
           {"name" => opts[:enroll_est_var_name], "regexp" => opts[:enroll_est_var_regexp]},
           {"name" => opts[:lab_var_name], "regexp" => opts[:lab_var_regexp]},
           {"name" => opts[:atp_duration_week_var_name], "regexp" => opts[:atp_duration_week_var_regexp]}
         ]
       }
      )

      #@request.add("DEBUG/enroll_est_var_name/%%_#{opts[:enroll_est_var_name]}%%", {}, {'subst' => 'true'})
      #@request.add("DEBUG/lab_var_name/%%_#{opts[:lab_var_name]}%%", {}, {'subst' => 'true'})
      #@request.add("DEBUG/atp_duration_week_var_name/%%_#{opts[:atp_duration_week_var_name]}%%", {}, {'subst' => 'true'})

      @request.add_thinktime(2)



      #
      # Learning Objectives
      #

      @request.add_thinktime(5)

      # Category
      for i in 1..opts[:lo_category].length
        if(i == opts[:lo_category].length)
          @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
            {
              'method' => 'POST',
              'content_type' => 'text/x-gwt-rpc; charset=utf-8',
              'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|lo.queryParam.loOptionalCategoryName|#{opts[:lo_category][0..itr]}|lo.search.loCategories|1|2|3|4|1|5|5|0|6|0|7|1|8|9|0|10|11|0|0|0|"
            },
            {
              :dyn_variables => [
                {"name" => opts[:lo_category_id_var_name], "regexp" => opts[:lo_category_id_var_regexp]}
              ]
            }
          )

          #@request.add("DEBUG/lo_category_id_var_name/%%_#{opts[:lo_category_id_var_name]}%%", {}, {'subst' => 'true'})

        else
          @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
            {
              'method' => 'POST',
              'content_type' => 'text/x-gwt-rpc; charset=utf-8',
              'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|lo.queryParam.loOptionalCategoryName|#{opts[:lo_category][0..itr]}|lo.search.loCategories|1|2|3|4|1|5|5|0|6|0|7|1|8|9|0|10|11|0|0|0|"
            }                             
          )
        end   
      end


      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/LoCategoryRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|8BA443A229D96519F33431B5D257DA6E|org.kuali.student.lum.common.client.lo.rpc.LoCategoryRpcService|getData|java.lang.String/2004016611|%%_#{opts[:lo_category_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {'subst' => 'true'}
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/LoCategoryRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|8BA443A229D96519F33431B5D257DA6E|org.kuali.student.lum.common.client.lo.rpc.LoCategoryRpcService|getLoCategoryType|java.lang.String/2004016611|loCategoryType.subject|1|2|3|4|1|5|6|"
        }
      )

      @request.add_thinktime(25)

      # Save & Continue
      contents1 = "5|0|152|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AC353D4ABD03D7D33CA737138E10D96B|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|passFail|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|STD|campusLocations|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loInfo|id|desc|formatted|#{opts[:lo_cat_text]}|plain|name|SINGLE USE LO|sequence|0|metaInfo|loCategoryInfoList|%%_#{opts[:lo_category_id_var_name]}%%|#{opts[:lo_category]}|loRepository|kuali.loRepository.key.singleUse|effectiveDate|org.kuali.student.core.assembly.data.Data$DateValue/3833457837|expirationDate|state|active|type|loCategoryType.subject|createId|admin|createTime|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|courseTitle|#{opts[:course_title]}|creditOptions|fixedCreditValue|10.0|kuali.creditType.credit.degree.10.0|#{opts[:propose_person]}|resultValues|draft|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.core.assembly.data.Data$IntegerValue/991919491|Semester|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|2|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|58|#{oversight_department}|unitsDeployment|28|#{admin_org}|variations|versionInfo|currentVersionStart|sequenceNumber|org.kuali.student.core.assembly.data.Data$LongValue/2873666547|java.lang.Long/4227064769|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Standard final Exam|proposal|%%_#{opts[:proposal_dyn_var_name]}%%|4|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|36|8|9|10|11|0|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|29|17|5|6|7|0|5|8|30|14|0|8|31|17|5|6|7|0|2|8|32|14|33|8|34|14|33|-41|-45|8|35|14|36|8|37|14|38|8|39|17|0|-37|-39|8|40|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|30|14|41|8|35|14|42|8|31|17|5|6|7|0|2|8|32|14|0|8|34|14|0|-65|-71|8|43|14|44|8|45|46|0|8|47|46|0|8|48|14|49|8|50|14|51|8|39|17|5|6|7|0|5|8|52|14|53|8|54|46|55|3759152200|1288490188800|0|8|56|14|53|8|57|46|55|3759152200|1288490188800|0|8|58|14|38|-65|-89|-61|-63|-37|-59|-33|-35|-1|8|28|8|59|14|60|8|61|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|62|14|63|8|30|14|64|8|39|17|5|6|7|0|5|8|52|14|65|8|54|46|55|2448822046|1297080123392|438000000|8|56|14|65|8|57|46|55|2448822046|1297080123392|438000000|8|58|14|38|-114|-120|8|66|17|5|6|7|0|1|18|-15|14|63|-114|-136|8|48|14|67|8|50|14|68|8|21|17|5|6|7|0|1|8|50|17|5|6|7|0|1|8|22|14|69|-148|-150|-114|-146|-110|-112|-1|-108|8|70|17|5|6|7|0|0|-1|-156|8|71|17|5|6|7|0|1|8|34|14|72|-1|-160|8|73|17|5|6|7|0|3|8|74|14|75|8|76|77|19|2|8|21|17|5|6|7|0|1|8|74|17|5|6|7|0|1|8|22|14|78|-177|-179|-168|-175|-1|-166|8|79|17|5|6|7|0|1|8|80|17|5|6|7|0|0|-187|-189|-1|-185|8|81|17|5|6|7|0|0|-1|-193|8|82|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|83|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|84|14|85|8|86|17|5|6|7|0|3|8|87|14|88|8|89|14|90|8|21|17|5|6|7|0|1|8|89|17|5|6|7|0|1|8|22|14|91|-225|-227|-217|-223|-211|-215|8|92|77|19|100|8|73|17|5|6|7|0|3|8|74|14|93|8|76|77|19|13|8|21|17|5|6|7|0|1|8|74|17|5|6|7|0|1|8|22|14|94|-247|-249|-238|-245|-211|-236|8|30|14|95|8|39|17|5|6|7|0|5|8|52|14|65|8|54|46|55|2448983416|1297080123392|808000000|8|56|14|65|8|57|46|55|2448983416|1297080123392|808000000|8|58|14|38|-211|-257|8|48|14|67|8|96|17|5|6|7|0|0|-211|-275|8|21|17|5|6|7|0|1|8|84|17|5|6|7|0|1|8|22|14|97|-281|-283|-211|-279|-207|-209|-203|-205|8|30|14|98|8|39|17|5|6|7|0|5|8|52|14|65|8|54|46|55|2448983411|1297080123392|803000000|8|56|14|65|8|57|46|55|2448983411|1297080123392|803000000|8|58|14|38|-203|-291|8|48|14|67|8|99|17|5|6|7|0|0|-203|-309|8|50|14|100|-199|-201|-1|-197|8|101|17|5|6|7|0|2|18|-15|14|102|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|103|-323|-325|-317|-321|-1|-315|8|30|14|104|8|105|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|106|14|107|8|21|17|5|6|7|0|1|8|106|17|5|6|7|0|1|8|22|14|108|-345|-347|-339|-343|-335|-337|-1|-333|8|109|17|5|6|7|0|0|-1|-353|8|110|14|111|8|39|17|5|6|7|0|5|8|52|14|65|8|54|46|55|2448974196|1297080123392|588000000|8|56|14|65|8|57|46|55|2448983387|1297080123392|779000000|8|58|14|112|-1|-359|8|113|10|-5|8|114|17|5|6|7|0|0|-1|-377|8|115|10|-5|8|48|14|67|8|116|14|117|8|99|17|5|6|7|0|2|18|-15|14|118|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|119|-395|-397|-389|-393|-1|-387|8|120|14|121|8|50|14|122|8|96|17|5|6|7|0|2|18|-15|14|123|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|124|-415|-417|-409|-413|-1|-407|8|125|17|5|6|7|0|2|18|-15|14|126|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|127|-431|-433|-425|-429|-1|-423|8|128|17|5|6|7|0|0|-1|-439|8|129|17|5|6|7|0|3|8|130|46|55|2448974195|1297080123392|587000000|8|131|132|133|1|0|8|134|14|135|-1|-443|8|21|17|5|6|7|0|2|8|116|17|5|6|7|0|1|8|22|14|117|-457|-459|8|13|17|5|6|7|0|1|8|22|14|136|-457|-465|-1|-455|8|137|17|5|6|7|0|11|8|30|14|138|8|39|17|5|6|7|0|5|8|52|14|65|8|54|46|55|2448974314|1297080123392|706000000|8|56|14|65|8|57|46|55|2448984332|1297080123392|724000000|8|58|14|139|-473|-477|8|35|14|60|8|140|17|5|6|7|0|1|18|-15|14|104|-473|-495|8|141|14|142|8|143|17|5|6|7|0|0|-473|-503|8|144|17|5|6|7|0|0|-473|-507|8|145|14|146|8|48|14|147|8|50|14|148|8|149|14|150|-1|-471|8|151|17|5|6|7|0|1|8|152|17|5|6|7|0|0|-521|-523|-1|-519|0|0|"
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "#{contents1}#{contents2}"
        },
        {
          'subst' => 'true',
          :dyn_variables => [
            {"name" => opts[:lo_category_var_name], "regexp" => opts[:lo_category_var_regexp]}
          ]
        }
      )

      #@request.add("DEBUG/lo_category_var_name/%%_#{opts[:lo_category_var_name]}%%", {}, {'subst' => 'true'})

      @request.add_thinktime(2)

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/LoCategoryRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|8BA443A229D96519F33431B5D257DA6E|org.kuali.student.lum.common.client.lo.rpc.LoCategoryRpcService|getLoCategoryTypes|1|2|3|4|0|"
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|824D21967CC7E5D9ACFFD480E621AE70|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|38793DBA0397DD45F127B8E6FCA0099C|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:clu_ref_dyn_var_name]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
        },
        {
          'subst' => 'true'
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
          'contents' => "5|0|9|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|38793DBA0397DD45F127B8E6FCA0099C|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|storeCourseStatements|java.lang.String/2004016611|java.util.Map|%%_#{opts[:clu_ref_dyn_var_name]}%%|java.util.HashMap/962170901|java.util.LinkedHashMap/1551059846|1|2|3|4|3|5|6|6|7|8|0|9|0|0|"
        },
        {
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/statementRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|824D21967CC7E5D9ACFFD480E621AE70|org.kuali.student.lum.program.client.rpc.StatementRpcService|getStatementTypesForStatementTypeForCourse|java.lang.String/2004016611|kuali.statement.type.course|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CourseRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|38793DBA0397DD45F127B8E6FCA0099C|org.kuali.student.lum.lu.ui.course.client.service.CourseRpcService|getCourseStatements|java.lang.String/2004016611|%%_#{opts[:clu_ref_dyn_var_name]}%%|KUALI.RULE|en|1|2|3|4|3|5|5|5|6|7|8|"
        },
        {
          'subst' => 'true'
        }
      )



      #
      # Active Dates
      # Start = Fall Sem 2008
      # End = 2nd Summer 2011

      @request.add_thinktime(10)

      # Save & Continue
      contents1 = "5|0|159|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AC353D4ABD03D7D33CA737138E10D96B|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|passFail|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|STD|campusLocations|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepository|kuali.loRepository.key.singleUse|metaInfo|createId|admin|createTime|org.kuali.student.core.assembly.data.Data$DateValue/3833457837|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|0|name|#{opts[:lo_category]}|state|active|type|loCategoryType.subject|loDisplayInfoList|loInfo|sequence|desc|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|loRepositoryKey|#{opts[:propose_person]}|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|fixedCreditValue|10.0|kuali.creditType.credit.degree.10.0|resultValues|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.core.assembly.data.Data$IntegerValue/991919491|Semester|expenditure|affiliatedOrgs|fees|formats|activities|activityType|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|1|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|3|pilotCourse|revenues|specialTopicsCourse|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|58|#{oversight_department}|unitsDeployment|28|#{admin_org}|variations|versionInfo|currentVersionStart|sequenceNumber|org.kuali.student.core.assembly.data.Data$LongValue/2873666547|java.lang.Long/4227064769|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Standard final Exam|dirty|startTerm|endTerm|proposal|%%_#{opts[:proposal_dyn_var_name]}%%|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators|kuali.atp.FA2008-2009|kuali.atp.SU2010-2011S2"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|38|8|9|10|11|0|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|30|14|31|8|32|14|33|8|34|17|5|6|7|0|5|8|35|14|36|8|37|38|39|3759152200|1288490188800|0|8|40|14|36|8|41|38|39|3759152200|1288490188800|0|8|42|14|43|-45|-51|8|44|14|45|8|46|14|47|8|48|14|49|-41|-43|-37|-39|8|50|17|5|6|7|0|0|-37|-73|8|51|17|5|6|7|0|8|8|52|14|43|8|53|17|5|6|7|0|2|8|54|14|55|8|56|14|55|-79|-83|8|30|14|57|8|58|14|33|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2451961197|1297080123392|589000000|8|40|14|59|8|41|38|39|2451961197|1297080123392|589000000|8|42|14|43|-79|-95|8|44|14|60|8|46|14|61|8|48|14|62|-37|-77|-33|-35|-1|-31|8|63|14|64|8|65|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|66|14|67|8|30|14|68|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2448822046|1297080123392|438000000|8|40|14|59|8|41|38|39|2448822046|1297080123392|438000000|8|42|14|43|-125|-131|8|69|17|5|6|7|0|1|18|-15|14|67|-125|-147|8|46|14|61|8|48|14|70|8|21|17|5|6|7|0|1|8|48|17|5|6|7|0|1|8|22|14|71|-159|-161|-125|-157|-121|-123|-1|-119|8|72|17|5|6|7|0|0|-1|-167|8|73|17|5|6|7|0|1|8|56|14|74|-1|-171|8|75|17|5|6|7|0|3|8|76|14|77|8|78|79|19|2|8|21|17|5|6|7|0|1|8|76|17|5|6|7|0|1|8|22|14|80|-188|-190|-179|-186|-1|-177|8|81|17|5|6|7|0|1|8|82|17|5|6|7|0|0|-198|-200|-1|-196|8|83|17|5|6|7|0|0|-1|-204|8|84|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|85|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|86|14|87|8|88|17|5|6|7|0|3|8|89|14|90|8|91|14|92|8|21|17|5|6|7|0|1|8|91|17|5|6|7|0|1|8|22|14|93|-236|-238|-228|-234|-222|-226|8|94|79|19|100|8|75|17|5|6|7|0|3|8|76|14|95|8|78|79|19|13|8|21|17|5|6|7|0|1|8|76|17|5|6|7|0|1|8|22|14|96|-258|-260|-249|-256|-222|-247|8|30|14|97|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2451957476|1297080123392|868000000|8|40|14|59|8|41|38|39|2451961172|1297080123392|564000000|8|42|14|98|-222|-268|8|46|14|61|8|99|17|5|6|7|0|0|-222|-286|8|21|17|5|6|7|0|1|8|86|17|5|6|7|0|1|8|22|14|100|-292|-294|-222|-290|-218|-220|-214|-216|8|30|14|101|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2451957468|1297080123392|860000000|8|40|14|59|8|41|38|39|2451961166|1297080123392|558000000|8|42|14|98|-214|-302|8|46|14|61|8|102|17|5|6|7|0|0|-214|-320|8|48|14|103|-210|-212|-1|-208|8|104|17|5|6|7|0|2|18|-15|14|105|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|106|-334|-336|-328|-332|-1|-326|8|30|14|107|8|108|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|109|14|110|8|21|17|5|6|7|0|1|8|109|17|5|6|7|0|1|8|22|14|111|-356|-358|-350|-354|-346|-348|-1|-344|8|112|17|5|6|7|0|0|-1|-364|8|113|14|114|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2451948836|1297080123392|228000000|8|40|14|59|8|41|38|39|2451961147|1297080123392|539000000|8|42|14|115|-1|-370|8|116|10|-5|8|117|17|5|6|7|0|0|-1|-388|8|118|10|-5|8|46|14|61|8|119|14|120|8|102|17|5|6|7|0|2|18|-15|14|121|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|122|-406|-408|-400|-404|-1|-398|8|123|14|124|8|48|14|125|8|99|17|5|6|7|0|2|18|-15|14|126|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|127|-426|-428|-420|-424|-1|-418|8|128|17|5|6|7|0|2|18|-15|14|129|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|130|-442|-444|-436|-440|-1|-434|8|131|17|5|6|7|0|0|-1|-450|8|132|17|5|6|7|0|3|8|133|38|39|2451948836|1297080123392|228000000|8|134|135|136|1|0|8|137|14|138|-1|-454|8|21|17|5|6|7|0|3|8|119|17|5|6|7|0|1|8|22|14|120|-468|-470|8|13|17|5|6|7|0|1|8|22|14|139|-468|-476|8|140|17|5|6|7|0|2|8|141|10|11|1|8|142|10|-488|-468|-482|-1|-466|8|143|17|5|6|7|0|11|8|30|14|144|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2451948932|1297080123392|324000000|8|40|14|59|8|41|38|39|2451962095|1297080123392|487000000|8|42|14|90|-493|-497|8|44|14|64|8|145|17|5|6|7|0|1|18|-15|14|107|-493|-515|8|146|14|147|8|148|17|5|6|7|0|0|-493|-523|8|149|17|5|6|7|0|0|-493|-527|8|150|14|151|8|46|14|152|8|48|14|153|8|154|14|155|-1|-491|8|156|17|5|6|7|0|1|8|157|17|5|6|7|0|0|-541|-543|-1|-539|-486|14|158|-489|14|159|0|0|"
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



      # Financials
      # $100 lab fee
      # Admin org 100% rev and exp

      @request.add_thinktime(5)

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|11|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|cachingSearch|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|enumeration.queryParam.enumerationType|kuali.lu.fee.feeType|enumeration.management.search|enumeration.resultColumn.sortKey|1|2|3|4|1|5|5|0|0|6|1|7|8|0|9|10|11|0|0|"
        }
      )

      # Revenue - Admin Org
      for i in 1..admin_org.length
        itr = i-1
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalLongName|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|java.lang.String/2004016611|kuali.org.Department|kuali.org.College|org.search.generic||1|2|3|4|1|5|5|0|6|0|7|2|8|9|0|10|8|11|7|2|12|13|12|14|0|15|16|0|0|"
          }    
        )    
      end

      @request.add_thinktime(5)

      # Expense - Admin Org
      for i in 1..admin_org.length
        if(i == admin_org.length)
          @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
            {
              'method' => 'POST',
              'content_type' => 'text/x-gwt-rpc; charset=utf-8',
              'contents' => "5|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalLongName|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|java.lang.String/2004016611|kuali.org.Department|kuali.org.College|org.search.generic||1|2|3|4|1|5|5|0|6|0|7|2|8|9|0|10|8|11|7|2|12|13|12|14|0|15|16|0|0|"
            },
            {
              :dyn_variables => [
                  {"name" => opts[:admin_dep_var_name], "regexp" => opts[:admin_dep_var_regexp]}
                ]
            } 
          )
        else
          @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
            {
              'method' => 'POST',
              'content_type' => 'text/x-gwt-rpc; charset=utf-8',
              'contents' => "5|0|16|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalLongName|#{admin_org[0..itr]}|org.queryParam.orgOptionalType|java.lang.String/2004016611|kuali.org.Department|kuali.org.College|org.search.generic||1|2|3|4|1|5|5|0|6|0|7|2|8|9|0|10|8|11|7|2|12|13|12|14|0|15|16|0|0|"
            }    
          )
        end    
      end

      #@request.add("DEBUG/admin_dep_var_name/%%_#{opts[:admin_dep_var_name]}%%", {}, {'subst' => 'true'})

      @request.add_thinktime(20)

      # Save & Continue
      contents1 = "5|0|174|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AC353D4ABD03D7D33CA737138E10D96B|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|passFail|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|STD|campusLocations|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepository|kuali.loRepository.key.singleUse|metaInfo|createId|admin|createTime|org.kuali.student.core.assembly.data.Data$DateValue/3833457837|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|0|name|#{opts[:lo_category]}|state|active|type|loCategoryType.subject|loDisplayInfoList|loInfo|sequence|desc|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|loRepositoryKey|#{opts[:propose_person]}|1|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|fixedCreditValue|10.0|kuali.creditType.credit.degree.10.0|resultValues|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.core.assembly.data.Data$IntegerValue/991919491|Semester|endTerm|kuali.atp.SU2010-2011S2|expenditure|affiliatedOrgs|dirty|orgId|percentage|created|28|org.kuali.student.core.assembly.data.Data$LongValue/2873666547|java.lang.Long/4227064769|fees|feeType|rateType|kuali.enum.type.feeTypes.labFee|fixedRateFee|feeAmounts|currencyQuantity|formats|activities|activityType|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|2|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|4|pilotCourse|revenues|specialTopicsCourse|startTerm|kuali.atp.FA2008-2009|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|58|#{oversight_department}|unitsDeployment|#{admin_org}|variations|versionInfo|currentVersionStart|sequenceNumber|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Fall Semester of 2008|Second Summer Session of 2011|Standard final Exam|proposal|%%_#{opts[:proposal_dyn_var_name]}%%|6|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators|feeJustification|Justification"
      contents2 = "|1|2|3|4|1|5|5|6|7|0|39|8|9|10|11|0|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|30|14|31|8|32|14|33|8|34|17|5|6|7|0|5|8|35|14|36|8|37|38|39|3759152200|1288490188800|0|8|40|14|36|8|41|38|39|3759152200|1288490188800|0|8|42|14|43|-45|-51|8|44|14|45|8|46|14|47|8|48|14|49|-41|-43|-37|-39|8|50|17|5|6|7|0|0|-37|-73|8|51|17|5|6|7|0|8|8|52|14|43|8|53|17|5|6|7|0|2|8|54|14|55|8|56|14|55|-79|-83|8|30|14|57|8|58|14|33|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2452677185|1297080123392|577000000|8|40|14|59|8|41|38|39|2452679868|1297080123392|260000000|8|42|14|60|-79|-95|8|44|14|61|8|46|14|62|8|48|14|63|-37|-77|-33|-35|-1|-31|8|64|14|65|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|67|14|68|8|30|14|69|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2448822046|1297080123392|438000000|8|40|14|59|8|41|38|39|2448822046|1297080123392|438000000|8|42|14|43|-125|-131|8|70|17|5|6|7|0|1|18|-15|14|68|-125|-147|8|46|14|62|8|48|14|71|8|21|17|5|6|7|0|1|8|48|17|5|6|7|0|1|8|22|14|72|-159|-161|-125|-157|-121|-123|-1|-119|8|73|17|5|6|7|0|0|-1|-167|8|74|17|5|6|7|0|1|8|56|14|75|-1|-171|8|76|17|5|6|7|0|3|8|77|14|78|8|79|80|19|2|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|81|-188|-190|-179|-186|-1|-177|8|82|14|83|8|84|17|5|6|7|0|1|8|85|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|21|17|5|6|7|0|3|8|86|17|5|6|7|0|2|8|87|10|11|1|8|88|10|-220|-212|-214|8|89|10|-220|-210|17|5|6|7|0|1|-214|17|5|6|7|0|1|-223|10|-220|-226|-214|-212|-210|-208|-210|-218|14|90|-221|91|92|100|0|-204|-206|-200|-202|-1|-198|8|93|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|-210|17|5|6|7|0|3|-214|17|5|6|7|0|2|8|94|10|-220|8|95|10|-220|-244|-214|8|89|10|-220|-210|17|5|6|7|0|1|-214|17|5|6|7|0|1|-253|10|-220|-256|-214|-244|-210|-241|-210|-249|14|96|-251|14|97|8|98|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|99|80|19|100|-210|17|5|6|7|0|1|-214|17|5|6|7|0|1|-272|10|-220|-276|-214|-270|-210|-266|-268|-241|-264|-237|-239|-1|-235|8|100|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|101|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|102|14|103|8|104|17|5|6|7|0|3|8|105|14|106|8|107|14|108|8|21|17|5|6|7|0|1|8|107|17|5|6|7|0|1|8|22|14|109|-310|-312|-302|-308|-296|-300|8|110|80|-274"
      contents3 = "|8|76|17|5|6|7|0|3|8|77|14|111|8|79|80|19|13|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|112|-331|-333|-322|-329|-296|-320|8|30|14|113|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2452673658|1297080123392|50000000|8|40|14|59|8|41|38|39|2452679838|1297080123392|230000000|8|42|14|114|-296|-341|8|46|14|62|8|115|17|5|6|7|0|0|-296|-359|8|21|17|5|6|7|0|1|8|102|17|5|6|7|0|1|8|22|14|116|-365|-367|-296|-363|-292|-294|-288|-290|8|30|14|117|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2452673654|1297080123392|46000000|8|40|14|59|8|41|38|39|2452679815|1297080123392|207000000|8|42|14|114|-288|-375|8|46|14|62|8|118|17|5|6|7|0|0|-288|-393|8|48|14|119|-284|-286|-1|-282|8|120|17|5|6|7|0|2|18|-15|14|121|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|122|-407|-409|-401|-405|-1|-399|8|30|14|123|8|124|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|125|14|126|8|21|17|5|6|7|0|1|8|125|17|5|6|7|0|1|8|22|14|127|-429|-431|-423|-427|-419|-421|-1|-417|8|128|17|5|6|7|0|0|-1|-437|8|129|14|130|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2452665762|1297080123392|154000000|8|40|14|59|8|41|38|39|2452679795|1297080123392|187000000|8|42|14|131|-1|-443|8|132|10|-5|8|133|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|85|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|-210|17|5|6|7|0|1|-214|17|5|6|7|0|2|8|87|10|-220|8|88|10|-220|-478|-214|-475|-210|-483|14|90|-485|91|-234|-471|-473|-467|-469|8|21|17|5|6|7|0|2|8|89|10|-220|-210|17|5|6|7|0|1|-214|17|5|6|7|0|1|-493|10|-220|-496|-214|-491|-210|-467|-489|-463|-465|-1|-461|8|134|10|-5|8|135|14|136|8|46|14|62|8|137|14|138|8|118|17|5|6|7|0|2|18|-15|14|139|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|140|-518|-520|-512|-516|-1|-510|8|141|14|142|8|48|14|143|8|115|17|5|6|7|0|2|18|-15|14|144|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|145|-538|-540|-532|-536|-1|-530|8|146|17|5|6|7|0|2|18|-15|14|90|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|147|-554|-556|-548|-552|-1|-546|8|148|17|5|6|7|0|0|-1|-562|8|149|17|5|6|7|0|3|8|150|38|39|2452665762|1297080123392|154000000|8|151|91|92|1|0|8|152|14|153|-1|-566|8|21|17|5|6|7|0|4|8|135|17|5|6|7|0|1|8|22|14|154|-580|-582|8|137|17|5|6|7|0|1|8|22|14|138|-580|-588|8|82|17|5|6|7|0|1|8|22|14|155|-580|-594|8|13|17|5|6|7|0|1|8|22|14|156|-580|-600|-1|-578|8|157|17|5|6|7|0|11|8|30|14|158|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2452665864|1297080123392|256000000|8|40|14|59|8|41|38|39|2452680704|1297080123392|96000000|8|42|14|159|-608|-612|8|44|14|65|8|160|17|5|6|7|0|1|18|-15|14|123|-608|-630|8|161|14|162|8|163|17|5|6|7|0|0|-608|-638|8|164|17|5|6|7|0|0|-608|-642|8|165|14|166|8|46|14|167|8|48|14|168|8|169|14|170|-1|-606|8|171|17|5|6|7|0|1|8|172|17|5|6|7|0|0|-656|-658|-1|-654|8|173|17|5|6|7|0|2|8|56|14|174|-210|17|5|6|7|0|1|-214|17|5|6|7|0|1|-666|10|-220|-669|-214|-664|-210|-1|-662|0|0|"
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "#{contents1}#{contents2}#{contents3}"
        },
        {
          'subst' => 'true',
          :dyn_variables => [
            {"name" => opts[:affliated_orgs_id_name], "regexp" => opts[:affliated_orgs_id_regexp]},
            {"name" => opts[:lab_fee_id_name], "regexp" => opts[:lab_fee_id_regexp]},
            {"name" => opts[:revenues_id_name], "regexp" => opts[:revenues_id_regexp]},
            {"name" => opts[:revenue_id_name], "regexp" => opts[:revenue_id_regexp]}
          ]
        }
      )

      #@request.add("DEBUG/affliated_orgs_id_name/%%_#{opts[:affliated_orgs_id_name]}%%", {}, {'subst' => 'true'})
      #@request.add("DEBUG/lab_fee_id_name/%%_#{opts[:lab_fee_id_name]}%%", {}, {'subst' => 'true'})
      #@request.add("DEBUG/revenues_id_name/%%_#{opts[:revenues_id_name]}%%", {}, {'subst' => 'true'})
      #@request.add("DEBUG/revenue_id_name/%%_#{opts[:revenue_id_name]}%%", {}, {'subst' => 'true'})

      @request.add_thinktime(2)

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|30A57CD4A0AA446B3B2B4CE52E1971E4|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|30A57CD4A0AA446B3B2B4CE52E1971E4|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|isAuthorizedAddReviewer|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|30A57CD4A0AA446B3B2B4CE52E1971E4|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|isAuthorizedRemoveReviewers|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true'
        }
      )



      #
      # Authors and Collaborators
      #

      @request.add_thinktime(5)

      if(!opts[:collaborator].nil?)
        # Collaborator seach
        for i in 1..opts[:collaborator].length
          itr = i-1
          @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
            {
              'method' => 'POST',
              'content_type' => 'text/x-gwt-rpc; charset=utf-8',
              'contents' => "5|0|12|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|person.queryParam.personGivenName|#{opts[:collaborator][0..itr]}|person.search.personQuickViewByGivenName|person.resultColumn.DisplayName|1|2|3|4|1|5|5|0|6|0|7|1|8|9|0|10|11|12|0|0|"
            }    
          )    
        end

        @request.add_thinktime(5)


        contents1 = "5|0|192|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AC353D4ABD03D7D33CA737138E10D96B|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|passFail|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|STD|campusLocations|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepository|kuali.loRepository.key.singleUse|metaInfo|createId|admin|createTime|org.kuali.student.core.assembly.data.Data$DateValue/3833457837|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|0|name|#{opts[:lo_category]}|state|active|type|loCategoryType.subject|loDisplayInfoList|loInfo|sequence|desc|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|loRepositoryKey|#{opts[:propose_person]}|2|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|fixedCreditValue|10.0|kuali.creditType.credit.degree.10.0|resultValues|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.core.assembly.data.Data$IntegerValue/991919491|Semester|endTerm|kuali.atp.SU2010-2011S2|expenditure|affiliatedOrgs|%%_#{opts[:affliated_orgs_id_name]}%%|orgId|%%_#{opts[:admin_dep_var_name]}%%|percentage|org.kuali.student.core.assembly.data.Data$LongValue/2873666547|java.lang.Long/4227064769|#{admin_org}|feeJustification|Justification|fees|feeAmounts|currencyQuantity|currencyTypeKey|kuali.currency.type.usdollars.cents|feeType|kuali.enum.type.feeTypes.labFee|%%_#{opts[:lab_fee_id_name]}%%|1|rateType|fixedRateFee|Fixed Rate Fee|Laboratory Fee|formats|activities|activityType|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|3|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|pilotCourse|revenues|%%_#{opts[:revenues_id_name]}%%|REVENUE|%%_#{opts[:revenue_id_name]}%%|specialTopicsCourse|startTerm|kuali.atp.FA2008-2009|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|58|#{oversight_department}|unitsDeployment|variations|versionInfo|currentVersionStart|sequenceNumber|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Fall Semester of 2008|Second Summer Session of 2011|Standard final Exam|proposal|%%_#{opts[:proposal_dyn_var_name]}%%|7|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators|principalId|#{opts[:collaborator]}|permission|KS-SYS~Edit Document|action|F|firstName|lastName|actionRequestStatus|New|author"
        contents2 = "|1|2|3|4|1|5|5|6|7|0|39|8|9|10|11|0|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|30|14|31|8|32|14|33|8|34|17|5|6|7|0|5|8|35|14|36|8|37|38|39|3759152200|1288490188800|0|8|40|14|36|8|41|38|39|3759152200|1288490188800|0|8|42|14|43|-45|-51|8|44|14|45|8|46|14|47|8|48|14|49|-41|-43|-37|-39|8|50|17|5|6|7|0|0|-37|-73|8|51|17|5|6|7|0|8|8|52|14|43|8|53|17|5|6|7|0|2|8|54|14|55|8|56|14|55|-79|-83|8|30|14|57|8|58|14|33|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2456212560|1297080123392|952000000|8|40|14|59|8|41|38|39|2456222073|1297080123392|465000000|8|42|14|60|-79|-95|8|44|14|61|8|46|14|62|8|48|14|63|-37|-77|-33|-35|-1|-31|8|64|14|65|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|67|14|68|8|30|14|69|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2448822046|1297080123392|438000000|8|40|14|59|8|41|38|39|2448822046|1297080123392|438000000|8|42|14|43|-125|-131|8|70|17|5|6|7|0|1|18|-15|14|68|-125|-147|8|46|14|62|8|48|14|71|8|21|17|5|6|7|0|1|8|48|17|5|6|7|0|1|8|22|14|72|-159|-161|-125|-157|-121|-123|-1|-119|8|73|17|5|6|7|0|0|-1|-167|8|74|17|5|6|7|0|1|8|56|14|75|-1|-171|8|76|17|5|6|7|0|3|8|77|14|78|8|79|80|19|2|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|81|-188|-190|-179|-186|-1|-177|8|82|14|83|8|84|17|5|6|7|0|1|8|85|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|30|14|86|8|87|14|88|8|89|90|91|100|0|8|21|17|5|6|7|0|1|8|87|17|5|6|7|0|1|8|22|14|92|-219|-221|-208|-217|-204|-206|-200|-202|-1|-198|8|93|17|5|6|7|0|1|8|56|14|94|-1|-227|8|95|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|96|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|97|80|19|100|8|98|14|99|-243|-245|-239|-241|8|100|14|101|8|30|14|102|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2456222004|1297080123392|396000000|8|40|14|59|8|41|38|39|2456222007|1297080123392|399000000|8|42|14|103|-239|-258|8|104|14|105|8|21|17|5|6|7|0|2|8|104|17|5|6|7|0|1|8|22|14|106|-278|-280|8|100|17|5|6|7|0|1|8|22|14|107|-278|-286|-239|-276|-235|-237|-1|-233|8|108|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|109|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|110|14|111|8|112|17|5|6|7|0|3|8|113|14|114|8|115|14|116|8|21|17|5|6|7|0|1|8|115|17|5|6|7|0|1|8|22|14|117|-320|-322|-312|-318|-306|-310|8|118|80|-251|8|76|17|5|6|7|0|3|8|77|14|119|8|79|80|19|13|8|21|17|5"
        contents3 = "|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|120|-341|-343|-332|-339|-306|-330|8|30|14|121|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2456209089|1297080123392|481000000|8|40|14|59|8|41|38|39|2456222044|1297080123392|436000000|8|42|14|122|-306|-351|8|46|14|62|8|123|17|5|6|7|0|0|-306|-369|8|21|17|5|6|7|0|1|8|110|17|5|6|7|0|1|8|22|14|124|-375|-377|-306|-373|-302|-304|-298|-300|8|30|14|125|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2456209085|1297080123392|477000000|8|40|14|59|8|41|38|39|2456222038|1297080123392|430000000|8|42|14|122|-298|-385|8|46|14|62|8|126|17|5|6|7|0|0|-298|-403|8|48|14|127|-294|-296|-1|-292|8|128|17|5|6|7|0|2|18|-15|14|129|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|130|-417|-419|-411|-415|-1|-409|8|30|14|131|8|132|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|133|14|134|8|21|17|5|6|7|0|1|8|133|17|5|6|7|0|1|8|22|14|135|-439|-441|-433|-437|-429|-431|-1|-427|8|136|17|5|6|7|0|0|-1|-447|8|137|14|138|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2456200694|1297080123392|86000000|8|40|14|59|8|41|38|39|2456222006|1297080123392|398000000|8|42|14|114|-1|-453|8|139|10|-5|8|140|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|85|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|30|14|141|8|87|14|88|8|89|90|91|100|0|8|21|17|5|6|7|0|1|8|87|17|5|6|7|0|1|8|22|14|92|-496|-498|-485|-494|-481|-483|-477|-479|8|100|14|142|8|30|14|143|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2456222004|1297080123392|396000000|8|40|14|59|8|41|38|39|2456222006|1297080123392|398000000|8|42|14|103|-477|-508|-473|-475|-1|-471|8|144|10|-5|8|145|14|146|8|46|14|62|8|147|14|148|8|126|17|5|6|7|0|2|18|-15|14|149|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|150|-540|-542|-534|-538|-1|-532|8|151|14|152|8|48|14|153|8|123|17|5|6|7|0|2|18|-15|14|154|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|155|-560|-562|-554|-558|-1|-552|8|156|17|5|6|7|0|2|18|-15|14|88|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|92|-576|-578|-570|-574|-1|-568|8|157|17|5|6|7|0|0|-1|-584|8|158|17|5|6|7|0|3|8|159|38|39|2456200694|1297080123392|86000000|8|160|90|91|1|0|8|161|14|162|-1|-588|8|21|17|5|6|7|0|4|8|145|17|5|6|7|0|1|8|22|14|163|-602|-604|8|147|17|5|6|7|0|1|8|22|14|148|-602|-610|8|82|17|5|6|7|0|1|8|22|14|164|-602|-616|8|13|17|5|6|7|0|1|8|22|14|165|-602|-622|-1|-600|8|166|17|5|6|7|0|11|8|30|14|167|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2456200791|1297080123392|183000000|8|40|14|59|8|41|38|39|2456222753|1297080123392|145000000|8|42|14|168|-630|-634|8|44|14|65|8|169|17|5|6|7|0|1|18|-15|14|131|-630|-652|8|170|14|171|8|172|17|5|6|7|0|0|-630|-660|8|173|17|5|6|7|0|0|-630|-664|8|174|14|175|8|46|14|176|8|48|14|177|8|178|14|179|-1|-628|8|180|17|5|6|7|0|1|8|181|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|182|14|183|8|184|14|185|8|186|14|187|8|188|14|183|8|189|14|183|8|190|14|191|8|192|10|-5|-682|-684|-678|-680|-1|-676|0|0|"
      else
        contents1 = "5|0|181|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|AC353D4ABD03D7D33CA737138E10D96B|org.kuali.student.lum.lu.ui.course.client.service.CreditCourseProposalRpcService|saveData|org.kuali.student.core.assembly.data.Data/3119441076|org.kuali.student.core.assembly.data.Data|java.util.LinkedHashMap/1551059846|org.kuali.student.core.assembly.data.Data$StringKey/1742996354|passFail|org.kuali.student.core.assembly.data.Data$BooleanValue/268767974|java.lang.Boolean/476441737|audit|finalExamStatus|org.kuali.student.core.assembly.data.Data$StringValue/3696151110|STD|campusLocations|org.kuali.student.core.assembly.data.Data$DataValue/4040075329|org.kuali.student.core.assembly.data.Data$IntegerKey/2690592210|java.lang.Integer/3438268394|AL|_runtimeData|id-translation|All|code|#{opts[:subject_area]}#{opts[:course_suffix]}|courseNumberSuffix|#{opts[:course_suffix]}|courseSpecificLOs|loCategoryInfoList|id|%%_#{opts[:lo_category_id_var_name]}%%|loRepository|kuali.loRepository.key.singleUse|metaInfo|createId|admin|createTime|org.kuali.student.core.assembly.data.Data$DateValue/3833457837|java.sql.Timestamp/1769758459|updateId|updateTime|versionInd|0|name|#{opts[:lo_category]}|state|active|type|loCategoryType.subject|loDisplayInfoList|loInfo|sequence|desc|formatted|#{opts[:lo_cat_text]}|plain|%%_#{opts[:lo_category_var_name]}%%|loRepositoryKey|#{opts[:propose_person]}|2|SINGLE USE LO|draft|kuali.lo.type.singleUse|courseTitle|#{opts[:course_title]}|creditOptions|fixedCreditValue|10.0|kuali.creditType.credit.degree.10.0|resultValues|kuali.resultComponentType.credit.degree.fixed|Credits, Fixed|crossListings|descr|#{opts[:course_description]}|duration|atpDurationTypeKey|kuali.atp.duration.Semester|timeQuantity|org.kuali.student.core.assembly.data.Data$IntegerValue/991919491|Semester|endTerm|kuali.atp.SU2010-2011S2|expenditure|affiliatedOrgs|%%_#{opts[:affliated_orgs_id_name]}%%|orgId|%%_#{opts[:admin_dep_var_name]}%%|percentage|org.kuali.student.core.assembly.data.Data$LongValue/2873666547|java.lang.Long/4227064769|#{admin_org}|feeJustification|Justification|fees|feeAmounts|currencyQuantity|currencyTypeKey|kuali.currency.type.usdollars.cents|feeType|kuali.enum.type.feeTypes.labFee|%%_#{opts[:lab_fee_id_name]}%%|1|rateType|fixedRateFee|Fixed Rate Fee|Laboratory Fee|formats|activities|activityType|kuali.lu.type.activity.Lab|contactHours|unitQuantity|5|unitType|kuali.atp.duration.week|per week|defaultEnrollmentEstimate|kuali.atp.duration.Week|Week|%%_#{opts[:atp_duration_week_var_name]}%%|3|unitsContentOwner|Lab|%%_#{opts[:lab_var_name]}%%|termsOffered|kuali.lu.type.CreditCourseFormatShell|gradingOptions|kuali.resultComponent.grade.letter|Letter|%%_#{opts[:clu_ref_dyn_var_name]}%%|instructors|personId|#{opts[:instructor]}|#{opts[:instructor]}, #{opts[:instructor]}(#{opts[:instructor]})|joints|level|100|pilotCourse|revenues|%%_#{opts[:revenues_id_name]}%%|REVENUE|%%_#{opts[:revenue_id_name]}%%|specialTopicsCourse|startTerm|kuali.atp.FA2008-2009|subjectArea|#{opts[:subject_area]}|kuali.atp.season.Any|Any|transcriptTitle|#{opts[:course_short_title]}|kuali.lu.type.CreditCourse|58|#{oversight_department}|unitsDeployment|variations|versionInfo|currentVersionStart|sequenceNumber|versionIndId|%%_#{opts[:version_ind_id_name]}%%|Fall Semester of 2008|Second Summer Session of 2011|Standard final Exam|proposal|%%_#{opts[:proposal_dyn_var_name]}%%|7|proposalReference|proposalReferenceType|kuali.proposal.referenceType.clu|proposerOrg|proposerPerson|rationale|#{opts[:course_rationale]}|Saved|kuali.proposal.type.course.create|workflowId|%%_#{opts[:proposal_doc_id_var_name]}%%|collaboratorInfo|collaborators"
        contents2 = "|1|2|3|4|1|5|5|6|7|0|39|8|9|10|11|0|8|12|10|-5|8|13|14|15|8|16|17|5|6|7|0|2|18|19|0|14|20|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|23|-19|-21|-12|-17|-1|-10|8|24|14|25|8|26|14|27|8|28|17|5|6|7|0|1|18|-15|17|5|6|7|0|3|8|29|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|30|14|31|8|32|14|33|8|34|17|5|6|7|0|5|8|35|14|36|8|37|38|39|3759152200|1288490188800|0|8|40|14|36|8|41|38|39|3759152200|1288490188800|0|8|42|14|43|-45|-51|8|44|14|45|8|46|14|47|8|48|14|49|-41|-43|-37|-39|8|50|17|5|6|7|0|0|-37|-73|8|51|17|5|6|7|0|8|8|52|14|43|8|53|17|5|6|7|0|2|8|54|14|55|8|56|14|55|-79|-83|8|30|14|57|8|58|14|33|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2458039801|1297080123392|193000000|8|40|14|59|8|41|38|39|2458049141|1297080123392|533000000|8|42|14|60|-79|-95|8|44|14|61|8|46|14|62|8|48|14|63|-37|-77|-33|-35|-1|-31|8|64|14|65|8|66|17|5|6|7|0|1|18|-15|17|5|6|7|0|7|8|67|14|68|8|30|14|69|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2448822046|1297080123392|438000000|8|40|14|59|8|41|38|39|2448822046|1297080123392|438000000|8|42|14|43|-125|-131|8|70|17|5|6|7|0|1|18|-15|14|68|-125|-147|8|46|14|62|8|48|14|71|8|21|17|5|6|7|0|1|8|48|17|5|6|7|0|1|8|22|14|72|-159|-161|-125|-157|-121|-123|-1|-119|8|73|17|5|6|7|0|0|-1|-167|8|74|17|5|6|7|0|1|8|56|14|75|-1|-171|8|76|17|5|6|7|0|3|8|77|14|78|8|79|80|19|2|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|81|-188|-190|-179|-186|-1|-177|8|82|14|83|8|84|17|5|6|7|0|1|8|85|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|30|14|86|8|87|14|88|8|89|90|91|100|0|8|21|17|5|6|7|0|1|8|87|17|5|6|7|0|1|8|22|14|92|-219|-221|-208|-217|-204|-206|-200|-202|-1|-198|8|93|17|5|6|7|0|1|8|56|14|94|-1|-227|8|95|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|96|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|97|80|19|100|8|98|14|99|-243|-245|-239|-241|8|100|14|101|8|30|14|102|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2458049034|1297080123392|426000000|8|40|14|59|8|41|38|39|2458049036|1297080123392|428000000|8|42|14|103|-239|-258|8|104|14|105|8|21|17|5|6|7|0|2|8|104|17|5|6|7|0|1|8|22|14|106|-278|-280|8|100|17|5|6|7|0|1|8|22|14|107|-278|-286|-239|-276|-235|-237|-1|-233|8|108|17|5|6|7|0|1|18|-15|17|5|6|7|0|6|8|109|17|5|6|7|0|1|18|-15|17|5|6|7|0|9|8|110|14|111|8|112|17|5|6|7|0|3|8|113|14|114|8|115|14|116|8|21|17|5|6|7|0|1|8|115|17|5|6|7|0|1|8|22|14|117|-320|-322|-312|-318|-306|-310|8|118|80|-251|8|76|17|5|6|7|0|3|8|77|14|119|8|79|80|19|13|8|21|17|5|6|7|0|1|8|77|17|5|6|7|0|1|8|22|14|120|-341|-343|-332|-339|-306|-330|8|30|14|121|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2458036464|1297080123392|856000000|8|40|14|59|8|41|38|39|2458049094"
        contents3 = "|1297080123392|486000000|8|42|14|122|-306|-351|8|46|14|62|8|123|17|5|6|7|0|0|-306|-369|8|21|17|5|6|7|0|1|8|110|17|5|6|7|0|1|8|22|14|124|-375|-377|-306|-373|-302|-304|-298|-300|8|30|14|125|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2458036460|1297080123392|852000000|8|40|14|59|8|41|38|39|2458049077|1297080123392|469000000|8|42|14|122|-298|-385|8|46|14|62|8|126|17|5|6|7|0|0|-298|-403|8|48|14|127|-294|-296|-1|-292|8|128|17|5|6|7|0|2|18|-15|14|129|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|130|-417|-419|-411|-415|-1|-409|8|30|14|131|8|132|17|5|6|7|0|1|18|-15|17|5|6|7|0|2|8|133|14|134|8|21|17|5|6|7|0|1|8|133|17|5|6|7|0|1|8|22|14|135|-439|-441|-433|-437|-429|-431|-1|-427|8|136|17|5|6|7|0|0|-1|-447|8|137|14|138|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2458028073|1297080123392|465000000|8|40|14|59|8|41|38|39|2458049036|1297080123392|428000000|8|42|14|114|-1|-453|8|139|10|-5|8|140|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|85|17|5|6|7|0|1|18|-15|17|5|6|7|0|4|8|30|14|141|8|87|14|88|8|89|90|91|100|0|8|21|17|5|6|7|0|1|8|87|17|5|6|7|0|1|8|22|14|92|-496|-498|-485|-494|-481|-483|-477|-479|8|100|14|142|8|30|14|143|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2458049034|1297080123392|426000000|8|40|14|59|8|41|38|39|2458049036|1297080123392|428000000|8|42|14|103|-477|-508|-473|-475|-1|-471|8|144|10|-5|8|145|14|146|8|46|14|62|8|147|14|148|8|126|17|5|6|7|0|2|18|-15|14|149|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|150|-540|-542|-534|-538|-1|-532|8|151|14|152|8|48|14|153|8|123|17|5|6|7|0|2|18|-15|14|154|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|155|-560|-562|-554|-558|-1|-552|8|156|17|5|6|7|0|2|18|-15|14|88|8|21|17|5|6|7|0|1|18|-15|17|5|6|7|0|1|8|22|14|92|-576|-578|-570|-574|-1|-568|8|157|17|5|6|7|0|0|-1|-584|8|158|17|5|6|7|0|3|8|159|38|39|2458028073|1297080123392|465000000|8|160|90|91|1|0|8|161|14|162|-1|-588|8|21|17|5|6|7|0|4|8|145|17|5|6|7|0|1|8|22|14|163|-602|-604|8|147|17|5|6|7|0|1|8|22|14|148|-602|-610|8|82|17|5|6|7|0|1|8|22|14|164|-602|-616|8|13|17|5|6|7|0|1|8|22|14|165|-602|-622|-1|-600|8|166|17|5|6|7|0|11|8|30|14|167|8|34|17|5|6|7|0|5|8|35|14|59|8|37|38|39|2458028191|1297080123392|583000000|8|40|14|59|8|41|38|39|2458049729|1297080123392|121000000|8|42|14|168|-630|-634|8|44|14|65|8|169|17|5|6|7|0|1|18|-15|14|131|-630|-652|8|170|14|171|8|172|17|5|6|7|0|0|-630|-660|8|173|17|5|6|7|0|0|-630|-664|8|174|14|175|8|46|14|176|8|48|14|177|8|178|14|179|-1|-628|8|180|17|5|6|7|0|1|8|181|17|5|6|7|0|0|-678|-680|-1|-676|0|0|"
      end

      # Save & Continue
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/CreditCourseProposalRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "#{contents1}#{contents2}#{contents3}"
        },
        {
          'subst' => 'true'
        }
      )


      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|EC09D8FD3DEC3F53F5BF11ACFAFA014A|org.kuali.student.common.ui.client.service.DocumentRpcService|isAuthorizedUploadDocuments|java.lang.String/2004016611|%%_#{opts[:proposal_dyn_var_name]}%%|referenceType.clu.proposal|1|2|3|4|2|5|5|6|7|"
        },
        {
          'subst' => 'true'
        }
      )
      # DUPE
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|EC09D8FD3DEC3F53F5BF11ACFAFA014A|org.kuali.student.common.ui.client.service.DocumentRpcService|isAuthorizedUploadDocuments|java.lang.String/2004016611|%%_#{opts[:proposal_dyn_var_name]}%%|referenceType.clu.proposal|1|2|3|4|2|5|5|6|7|"
        },
        {
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|EC09D8FD3DEC3F53F5BF11ACFAFA014A|org.kuali.student.common.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:proposal_dyn_var_name]}%%|1|2|3|4|2|5|5|6|7|"
        },
        {
          'subst' => 'true'
        }
      )
      # DUPE
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|EC09D8FD3DEC3F53F5BF11ACFAFA014A|org.kuali.student.common.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:proposal_dyn_var_name]}%%|1|2|3|4|2|5|5|6|7|"
        },
        {
          'subst' => 'true'
        }
      )



      #
      # Support Documents
      # Nothing uploaded

      @request.add_thinktime(5)

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/DocumentRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|EC09D8FD3DEC3F53F5BF11ACFAFA014A|org.kuali.student.common.ui.client.service.DocumentRpcService|getRefDocIdsForRef|java.lang.String/2004016611|kuali.org.RefObjectType.ProposalInfo|%%_#{opts[:proposal_dyn_var_name]}%%|1|2|3|4|2|5|5|6|7|"
        },
        {
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|30A57CD4A0AA446B3B2B4CE52E1971E4|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|30A57CD4A0AA446B3B2B4CE52E1971E4|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
        },
        {
          'subst' => 'true'
        }
      )


      @request.add_thinktime(5)


      # Submit to worflow
      if(opts[:submit])
        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|30A57CD4A0AA446B3B2B4CE52E1971E4|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|submitDocumentWithId|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
          },
          {
            'subst' => 'true'
          }
        )

        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|30A57CD4A0AA446B3B2B4CE52E1971E4|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getActionsRequested|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
          },
          {
            'subst' => 'true'
          }
        )

        @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/WorkflowRpcService',
          {
            'method' => 'POST',
            'content_type' => 'text/x-gwt-rpc; charset=utf-8',
            'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|30A57CD4A0AA446B3B2B4CE52E1971E4|org.kuali.student.core.workflow.ui.client.service.WorkflowRpcService|getDocumentStatus|java.lang.String/2004016611|%%_#{opts[:proposal_doc_id_var_name]}%%|1|2|3|4|1|5|6|"
          },
          {
            'subst' => 'true'
          }
        )
      end
    
  end
  
  
  # Currently not working in 1.1
  def edit_proposal(proposal_name, opts={})
    
    defaults = {
      :proposal_id_dyn_var => 'ep_proposal_id',
      :proposal_id_regexp => 'proposal.resultColumn.proposalId\"\,\"\([^\"]+\)',
      #:proposal_dyn_var => 'ep_proposal',
      #:proposal_regexp => 'proposal\"\,\"\([^\"]+\)',
      :proposal_num_dyn_var => 'ep_proposal_num',
      :proposal_num_regexp => 'proposal\"\,\"[^\"]+\"\,\"\([^\"]+\)',
      :workflow_id_dyn_var => 'ep_workflow_id',
      :workflow_id_regexp => 'workflowId\"\,\"\([^\"]+\)',
      :id_translation_id_dyn_var => 'ep_id_translation_id',
      :id_translation_id_regexp => 'id-translation\"\,\"\([^\"]+\)',
      :code_dyn_var => 'ep_code',
      :code_regexp => 'code\"\,\"\([^\"]+\)',
      :course_num_suffix_dyn_var => 'ep_course_num_suffix',
      :course_num_suffix_regexp => 'courseNumberSuffix\"\,\"\([^\"]+\)',
      :lo_category_id_dyn_var => 'ep_lo_cat_id',
      :lo_category_id_regexp => 'expirationDate\"\,\"id\"\,\"\([^\"]+\)',
      :lo_category_dyn_var => 'ep_lo_cat',
      :lo_category_regexp => 'name\"\,\"\([^\"]+\)',
      :lo_cat_text_dyn_var => 'ep_lo_cat_text',
      :lo_cat_text_regexp => 'loInfo\"\,\"sequence\"\,\"0\"\,\"\([^\"]+\)',
      :lo_cat_id_dyn_var => 'ep_lo_cat_id',
      :lo_cat_id_regexp => '\([^\"]+\)\"\,\"loRepositoryKey',
      :create_id_dyn_var => 'ep_create_id',
      :create_id_regexp => 'createId\"\,\"\([^\"]+\)',
      :course_title_dyn_var => 'ep_course_title',
      :course_title_regexp => 'courseTitle\"\,\"\([^\"]+\)',
      :oversight_org_dyn_var => 'ep_oversight_org',
      :oversight_org_regexp => 'curriculumOversightOrgs\"\,\"[^\,]+\,\"\([^\"]+\)',
      :lab_fee_id_dyn_var => 'ep_lab_fee_id',
      :lab_fee_id_regexp => 'kuali.enum.type.feeTypes.labFee\"\,\"\([^\"]+\)',
      :atp_dur_week_id_dyn_var => 'ep_atp_dur_week_id',
      :atp_dur_week_id_regexp => 'kuali.atp.duration.Week\"\,\"Week\"\,\"\([^\"]+\)',
      :lab_id_dyn_var => 'ep_lab_id',
      :lab_id_regexp => 'Lab\"\,\"\([^\"]+\)',
      :grade_id_dyn_var => 'ep_grade_id',
      :grade_id_regexp => 'kuali.resultComponent.grade[^\,]+\,\"[^\,]+\,\"\([^\"]+\)',
      :person_id_dyn_var => 'ep_person_id',
      :person_id_regexp => 'personId\"\,\"\([^\"]+\)',
      :joints_dyn_var => 'ep_joints',
      :joints_regexp => 'joints\"\,\"\([^\"]+\)',
      :subject_area_dyn_var => 'ep_subject_area',
      :subject_area_regexp => 'subjectArea\"\,\"\([^\"]+\)',
      :title_dyn_var => 'ep_title',
      :title_regexp => 'proposal\"\,\"[^\"]+\"\,\"[^\"]+\"\,\"\([^\"]+\)',
      :rationale_dyn_var => 'ep_rationale',
      :rationale_regexp => 'rationale\"\,\"\([^\"]+\)',
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
          {"name" => opts[:proposal_id_dyn_var], "regexp" => opts[:proposal_id_regexp]}
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
          {"name" => opts[:workflow_id_dyn_var], "regexp" => opts[:workflow_id_regexp]},
          {"name" => opts[:id_translation_id_dyn_var], "regexp" => opts[:id_translation_id_regexp]},
          {"name" => opts[:code_dyn_var], "regexp" => opts[:code_regexp]},
          {"name" => opts[:course_num_suffix_dyn_var], "regexp" => opts[:course_num_suffix_regexp]},
          {"name" => opts[:lo_category_id_dyn_var], "regexp" => opts[:lo_category_id_regexp]},
          {"name" => opts[:lo_category_dyn_var], "regexp" => opts[:lo_category_dyn_var]},
          {"name" => opts[:lo_cat_text_dyn_var], "regexp" => opts[:lo_cat_text_regexp]},
          {"name" => opts[:lo_cat_id_dyn_var], "regexp" => opts[:lo_cat_id_regexp]},
          {"name" => opts[:create_id_dyn_var], "regexp" => opts[:create_id_regexp]},
          {"name" => opts[:course_title_dyn_var], "regexp" => opts[:course_title_regexp]},
          {"name" => opts[:oversight_org_dyn_var], "regexp" => opts[:oversight_org_regexp]},
          {"name" => opts[:lab_fee_id_dyn_var], "regexp" => opts[:lab_fee_id_regexp]},
          {"name" => opts[:atp_dur_week_id_dyn_var], "regexp" => opts[:atp_dur_week_id_regexp]},
          {"name" => opts[:lab_id_dyn_var], "regexp" => opts[:lab_id_regexp]},
          {"name" => opts[:grade_id_dyn_var], "regexp" => opts[:grade_id_regexp]},
          {"name" => opts[:person_id_dyn_var], "regexp" => opts[:person_id_regexp]},
          {"name" => opts[:joints_dyn_var], "regexp" => opts[:joints_regexp]},
          {"name" => opts[:subject_area_dyn_var], "regexp" => opts[:subject_area_regexp]},
          {"name" => opts[:proposal_dyn_var], "regexp" => opts[:proposal_regexp]},
          {"name" => opts[:proposal_num_dyn_var], "regexp" => opts[:proposal_num_regexp]},
          {"name" => opts[:title_dyn_var], "regexp" => opts[:title_regexp]},
          {"name" => opts[:rationale_dyn_var], "regexp" => opts[:rationale_regexp]}
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
  # Currently not working in 1.1
  def find(type, name, opts={})
    
    defaults = {
      :nav_homepage => true,
      :course_description => '',
      :course_number => ''
    }
    
    opts = defaults.merge(opts)
    
    # Navigate to Curriculum Mgmt
    self.homepage() unless(!opts[:nav_homepage])
    
    
    # Search Criteria
    if(type == "proposal")
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|13|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|proposal.queryParam.proposalOptionalName|#{name}|proposal.search.generic|proposal.resultColumn.proposalOptionalName|1|2|3|4|1|5|6|0|7|0|8|1|9|10|0|11|12|13|0|0|"
        }
      )
    elsif(type == "course")
      # Only searching by title/name
      contents = (name == '' ? "5|0|13|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Integer/3438268394|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.search.generic|org.resultColumn.orgShortName|1|2|3|4|1|5|5|6|10|7|0|8|1|9|10|0|11|12|13|0|6|0|" : 
                               "5|0|15|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|648421FAE6C751B6B3D6A2EC5262F586|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Integer/3438268394|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|lu.queryParam.luOptionalLongName|#{name}|lu.queryParam.luOptionalType|kuali.lu.type.CreditCourse|lu.search.generic|org.resultColumn.orgShortName|1|2|3|4|1|5|5|6|10|7|0|8|2|9|10|0|11|9|12|0|13|14|15|0|6|0|")
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => contents
        }
      )

    end
    
  end
    
end