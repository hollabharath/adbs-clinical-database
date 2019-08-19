rm(list=ls())

# Load all individual irle tables and rename the columns
irle_wrk <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_work_table.csv")
names(irle_wrk) <-   c("id_wrk", "subjectID", "assessmentId", "test_taken_by_wrk",
                       "m_recent_wrk_change_in_work" , "m_recent_wrk_change_in_work_conditions" , "m_recent_wrk_change_work_hours_incl_2nd_job" , "m_recent_wrk_trouble_rows" , "m_recent_wrk_promotion" , "m_recent_wrk_demotion" , "m_recent_wrk_redundant" , "m_recent_wrk_retirement" , "m_recent_wrk_unemployed" , "m_recent_wrk_failure_of_business" , 
                       "n_recent_wrk_change_in_work" , "n_recent_wrk_change_in_work_conditions" , "n_recent_wrk_change_work_hours_incl_2nd_job" , "n_recent_wrk_trouble_rows" , "n_recent_wrk_promotion" , "n_recent_wrk_demotion" , "n_recent_wrk_redundant" , "n_recent_wrk_retirement" , "n_recent_wrk_unemployed" , "n_recent_wrk_failure_of_business" , 
                       "i_recent_wrk_change_in_work" , "i_recent_wrk_change_in_work_conditions" , "i_recent_wrk_change_work_hours_incl_2nd_job" , "i_recent_wrk_trouble_rows" , "i_recent_wrk_promotion" , "i_recent_wrk_demotion" , "i_recent_wrk_redundant" , "i_recent_wrk_retirement" , "i_recent_wrk_unemployed" , "i_recent_wrk_failure_of_business" , 
                       "m_onset_wrk_change_in_work" , "m_onset_wrk_change_in_work_conditions" , "m_onset_wrk_change_work_hours_incl_2nd_job" , "m_onset_wrk_trouble_rows" , "m_onset_wrk_promotion" , "m_onset_wrk_demotion" , "m_onset_wrk_redundant" , "m_onset_wrk_retirement" , "m_onset_wrk_unemployed" , "m_onset_wrk_failure_of_business" , 
                       "n_onset_wrk_change_in_work" , "n_onset_wrk_change_in_work_conditions" , "n_onset_wrk_change_work_hours_incl_2nd_job" , "n_onset_wrk_trouble_rows" , "n_onset_wrk_promotion" , "n_onset_wrk_demotion" , "n_onset_wrk_redundant" , "n_onset_wrk_retirement" , "n_onset_wrk_unemployed" , "n_onset_wrk_failure_of_business" , 
                       "i_onset_wrk_change_in_work" , "i_onset_wrk_change_in_work_conditions" , "i_onset_wrk_change_work_hours_incl_2nd_job" , "i_onset_wrk_trouble_rows" , "i_onset_wrk_promotion" , "i_onset_wrk_demotion" , "i_onset_wrk_redundant" , "i_onset_wrk_retirement" , "i_onset_wrk_unemployed" , "i_onset_wrk_failure_of_business" ,
                       "status_wrk", "comments_wrk", "deviceid_wrk", "date_of_last_update_wrk")

irle_edu <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_education_table.csv")
names(irle_edu) <- c("id_edu" , "subjectID" , "assessmentId" , "test_taken_by_edu" , 
                     "m_recent_edu_begin_education" , "m_recent_edu_change_school" , "m_recent_edu_cease_full_education" , "m_recent_edu_academic_failure" , "m_recent_edu_important_exam" ,
                     "n_recent_edu_begin_education" , "n_recent_edu_change_school" , "n_recent_edu_cease_full_education" , "n_recent_edu_academic_failure" , "n_recent_edu_important_exam" ,
                     "i_recent_edu_begin_education" , "i_recent_edu_change_school" , "i_recent_edu_cease_full_education" , "i_recent_edu_academic_failure" , "i_recent_edu_important_exam" ,
                     "m_onset_edu_begin_education" , "m_onset_edu_change_school" , "m_onset_edu_cease_full_education" , "m_onset_edu_academic_failure" , "m_onset_edu_important_exam" ,
                     "n_onset_edu_begin_education" , "n_onset_edu_change_school" , "n_onset_edu_cease_full_education" , "n_onset_edu_academic_failure" , "n_onset_edu_important_exam" ,
                     "i_onset_edu_begin_education" , "i_onset_edu_change_school" , "i_onset_edu_cease_full_education" , "i_onset_edu_academic_failure" , "i_onset_edu_important_exam" , 
                     "status_edu" , "comments_edu" , "deviceid_edu" , "date_of_last_update_edu")

irle_fam <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_familyandsocial_table.csv")
names(irle_fam) <- c("id_fam" , "subjectID" , "assessmentId" , "test_taken_by_fam" , 
                     "m_recent_fam_birth_child_father" , "m_recent_fam_adoption_child" , "m_recent_fam_new_person_in_household" , "m_recent_fam_child_engaged" , "m_recent_fam_child_married_approve" , "m_recent_fam_child_married_disapprove" , "m_recent_fam_child_leaves_home_other_reason" , "m_recent_fam_increased_arguments_resid_fam" , "m_recent_fam_major_arugments_non-resid_famfriend" , "m_recent_fam_marked_improvemt_rel_fam" , "m_recent_fam_separation_from_significant_person" , "m_recent_fam_marital_problems_in_close_family" , 
                     "n_recent_fam_birth_child_father" , "n_recent_fam_adoption_child" , "n_recent_fam_new_person_in_household" , "n_recent_fam_child_engaged" , "n_recent_fam_child_married_approve" , "n_recent_fam_child_married_disapprove" , "n_recent_fam_child_leaves_home_other_reason" , "n_recent_fam_increased_arguments_resid_fam" , "n_recent_fam_major_arugments_non-resid_famfriend" , "n_recent_fam_marked_improvemt_rel_fam" , "n_recent_fam_separation_from_significant_person" , "n_recent_fam_marital_problems_in_close_family" , 
                     "i_recent_fam_birth_child_father" , "i_recent_fam_adoption_child" , "i_recent_fam_new_person_in_household" , "i_recent_fam_child_engaged" , "i_recent_fam_child_married_approve" , "i_recent_fam_child_married_disapprove" , "i_recent_fam_child_leaves_home_other_reason" , "i_recent_fam_increased_arguments_resid_fam" , "i_recent_fam_major_arugments_non-resid_famfriend" , "i_recent_fam_marked_improvemt_rel_fam" , "i_recent_fam_separation_from_significant_person" , "i_recent_fam_marital_problems_in_close_family" , 
                     "m_onset_fam_birth_child_father" , "m_onset_fam_adoption_child" , "m_onset_fam_new_person_in_household" , "m_onset_fam_child_engaged" , "m_onset_fam_child_married_approve" , "m_onset_fam_child_married_disapprove" , "m_onset_fam_child_leaves_home_other_reason" , "m_onset_fam_increased_arguments_resid_fam" , "m_onset_fam_major_arugments_non-resid_famfriend" , "m_onset_fam_marked_improvemt_rel_fam" , "m_onset_fam_separation_from_significant_person" , "m_onset_fam_marital_problems_in_close_family" , 
                     "n_onset_fam_birth_child_father" , "n_onset_fam_adoption_child" , "n_onset_fam_new_person_in_household" , "n_onset_fam_child_engaged" , "n_onset_fam_child_married_approve" , "n_onset_fam_child_married_disapprove" , "n_onset_fam_child_leaves_home_other_reason" , "n_onset_fam_increased_arguments_resid_fam" , "n_onset_fam_major_arugments_non-resid_famfriend" , "n_onset_fam_marked_improvemt_rel_fam" , "n_onset_fam_separation_from_significant_person" , "n_onset_fam_marital_problems_in_close_family" , 
                     "i_onset_fam_birth_child_father" , "i_onset_fam_adoption_child" , "i_onset_fam_new_person_in_household" , "i_onset_fam_child_engaged" , "i_onset_fam_child_married_approve" , "i_onset_fam_child_married_disapprove" , "i_onset_fam_child_leaves_home_other_reason" , "i_onset_fam_increased_arguments_resid_fam" , "i_onset_fam_major_arugments_non-resid_famfriend" , "i_onset_fam_marked_improvemt_rel_fam" , "i_onset_fam_separation_from_significant_person" , "i_onset_fam_marital_problems_in_close_family" , 
                     "status_fam" , "comments_fam" , "deviceid_fam" , "date_of_last_update_fam")

irle_mar <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_marital_table1.csv")
names(irle_mar) <- c("id_mar" , "subjectID" , "assessmentId" , "test_taken_by_mar" , 
                     "m_recent_mar_marriage" , "m_recent_mar_serious_arguments_with_spouse" , "m_recent_mar_separate_not_arguments_month" , "m_recent_mar_marital_separate_arguments" , "m_recent_mar_spouse_extra_marital_affair" , "m_recent_mar_patient_extra_marital_affair" , "m_recent_mar_marked_improvement_in_rels_with_spouse" , "m_recent_mar_marital_reconcile" , "m_recent_mar_divorce_decree" ,
                     "n_recent_mar_marriage" , "n_recent_mar_serious_arguments_with_spouse" , "n_recent_mar_separate_not_arguments_month" , "n_recent_mar_marital_separate_arguments" , "n_recent_mar_spouse_extra_marital_affair" , "n_recent_mar_patient_extra_marital_affair" , "n_recent_mar_marked_improvement_in_rels_with_spouse" , "n_recent_mar_marital_reconcile" , "n_recent_mar_divorce_decree" ,
                     "i_recent_mar_marriage" , "i_recent_mar_serious_arguments_with_spouse" , "i_recent_mar_separate_not_arguments_month" , "i_recent_mar_marital_separate_arguments" , "i_recent_mar_spouse_extra_marital_affair" , "i_recent_mar_patient_extra_marital_affair" , "i_recent_mar_marked_improvement_in_rels_with_spouse" , "i_recent_mar_marital_reconcile" , "i_recent_mar_divorce_decree" ,
                     "m_onset_mar_marriage" , "m_onset_mar_serious_arguments_with_spouse" , "m_onset_mar_separate_not_arguments_month" , "m_onset_mar_marital_separate_arguments" , "m_onset_mar_spouse_extra_marital_affair" , "m_onset_mar_patient_extra_marital_affair" , "m_onset_mar_marked_improvement_in_rels_with_spouse" , "m_onset_mar_marital_reconcile" , "m_onset_mar_divorce_decree" ,
                     "n_onset_mar_marriage" , "n_onset_mar_serious_arguments_with_spouse" , "n_onset_mar_separate_not_arguments_month" , "n_onset_mar_marital_separate_arguments" , "n_onset_mar_spouse_extra_marital_affair" , "n_onset_mar_patient_extra_marital_affair" , "n_onset_mar_marked_improvement_in_rels_with_spouse" , "n_onset_mar_marital_reconcile" , "n_onset_mar_divorce_decree" ,
                     "i_onset_mar_marriage" , "i_onset_mar_serious_arguments_with_spouse" , "i_onset_mar_separate_not_arguments_month" , "i_onset_mar_marital_separate_arguments" , "i_onset_mar_spouse_extra_marital_affair" , "i_onset_mar_patient_extra_marital_affair" , "i_onset_mar_marked_improvement_in_rels_with_spouse" , "i_onset_mar_marital_reconcile" , "i_onset_mar_divorce_decree",
                     "status_mar" , "comments_mar" , "deviceid_mar" , "date_of_last_update_mar")

irle_fin <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_financial_table.csv")
names(irle_fin) <- c("id_fin" , "subjectID" , "assessmentId_fin" , "test_taken_by_fin" , 
                     "m_recent_fin_moderate_financial_difficulties" , "m_recent_fin_major_financial_difficulties" , "m_recent_fin_major_improvemt_in_finance" , 
                     "n_recent_fin_moderate_financial_difficulties" , "n_recent_fin_major_financial_difficulties" , "n_recent_fin_major_improvemt_in_finance" , 
                     "i_recent_fin_moderate_financial_difficulties" , "i_recent_fin_major_financial_difficulties" , "i_recent_fin_major_improvemt_in_finance" , 
                     "m_onset_fin_moderate_financial_difficulties" , "m_onset_fin_major_financial_difficulties" , "m_onset_fin_major_improvemt_in_finance" , 
                     "n_onset_fin_moderate_financial_difficulties" , "n_onset_fin_major_financial_difficulties" , "n_onset_fin_major_improvemt_in_finance" , 
                     "i_onset_fin_moderate_financial_difficulties" , "i_onset_fin_major_financial_difficulties" , "i_onset_fin_major_improvemt_in_finance" ,
                     "status_fin" , "comments_fin" , "deviceid_fin" , "date_of_last_update_fin")

irle_hlt <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_health_table.csv")
names(irle_hlt) <- c("id_hlt " , "subjectID" , "assessmentId" , "test_taken_by_hlt " , 
                     "m_recent_hlt_major_physical_illness" , "m_recent_hlt_major_illness_close_family" , "m_recent_hlt_wanted_pregnancy" , "m_recent_hlt_unwanted_pregnancy" , "m_recent_hlt_miscarriage_still_birth_abortion" , "m_recent_hlt_birth_live_child_mother" , "m_recent_hlt_menopause" , 
                     "n_recent_hlt_major_physical_illness" , "n_recent_hlt_major_illness_close_family" , "n_recent_hlt_wanted_pregnancy" , "n_recent_hlt_unwanted_pregnancy" , "n_recent_hlt_miscarriage_still_birth_abortion" , "n_recent_hlt_birth_live_child_mother" , "n_recent_hlt_menopause" , 
                     "i_recent_hlt_major_physical_illness" , "i_recent_hlt_major_illness_close_family" , "i_recent_hlt_wanted_pregnancy" , "i_recent_hlt_unwanted_pregnancy" , "i_recent_hlt_miscarriage_still_birth_abortion" , "i_recent_hlt_birth_live_child_mother" , "i_recent_hlt_menopause" , 
                     "m_onset_hlt_major_physical_illness" , "m_onset_hlt_major_illness_close_family" , "m_onset_hlt_wanted_pregnancy" , "m_onset_hlt_unwanted_pregnancy" , "m_onset_hlt_miscarriage_still_birth_abortion" , "m_onset_hlt_birth_live_child_mother" , "m_onset_hlt_menopause" , 
                     "n_onset_hlt_major_physical_illness" , "n_onset_hlt_major_illness_close_family" , "n_onset_hlt_wanted_pregnancy" , "n_onset_hlt_unwanted_pregnancy" , "n_onset_hlt_miscarriage_still_birth_abortion" , "n_onset_hlt_birth_live_child_mother" , "n_onset_hlt_menopause" , 
                     "i_onset_hlt_major_physical_illness" , "i_onset_hlt_major_illness_close_family" , "i_onset_hlt_wanted_pregnancy" , "i_onset_hlt_unwanted_pregnancy" , "i_onset_hlt_miscarriage_still_birth_abortion" , "i_onset_hlt_birth_live_child_mother" , "i_onset_hlt_menopause" ,
                     "status_hlt" , "comments_hlt" , "deviceid_hlt" , "date_of_last_update_hlt")

irle_brv <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_bereavement_table.csv")
names(irle_brv) <- c("id_brv" , "subjectID" , "assessmentId" , "test_taken_by_brv" , 
                     "m_recent_brv_death_of_close_friend" , "m_recent_brv_death_of_close_family" , "m_recent_brv_death_of_child" , "m_recent_brv_death_of_spouse" , "m_recent_brv_loss_robbery_personal_value" , 
                     "n_recent_brv_death_of_close_friend" , "n_recent_brv_death_of_close_family" , "n_recent_brv_death_of_child" , "n_recent_brv_death_of_spouse" , "n_recent_brv_loss_robbery_personal_value" , 
                     "i_recent_brv_death_of_close_friend" , "i_recent_brv_death_of_close_family" , "i_recent_brv_death_of_child" , "i_recent_brv_death_of_spouse" , "i_recent_brv_loss_robbery_personal_value" , 
                     "m_onset_brv_death_of_close_friend" , "m_onset_brv_death_of_close_family" , "m_onset_brv_death_of_child" , "m_onset_brv_death_of_spouse" , "m_onset_brv_loss_robbery_personal_value" , 
                     "n_onset_brv_death_of_close_friend" , "n_onset_brv_death_of_close_family" , "n_onset_brv_death_of_child" , "n_onset_brv_death_of_spouse" , "n_onset_brv_loss_robbery_personal_value" , 
                     "i_onset_brv_death_of_close_friend" , "i_onset_brv_death_of_close_family" , "i_onset_brv_death_of_child" , "i_onset_brv_death_of_spouse" , "i_onset_brv_loss_robbery_personal_value" ,
                     "status_brv" , "comments_brv" , "deviceid_brv" , "date_of_last_update_brv")

irle_mig <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_migration_table.csv")
names(irle_mig) <- c("id_mig" , "subjectID" , "assessmentId" , "test_taken_by_mig" , 
                     "m_recent_mig_move_within_city" , "m_recent_mig_move_to_another_city" , "m_recent_mig_move_to_another_country" , 
                     "n_recent_mig_move_within_city" , "n_recent_mig_move_to_another_city" , "n_recent_mig_move_to_another_country" , 
                     "i_recent_mig_move_within_city" , "i_recent_mig_move_to_another_city" , "i_recent_mig_move_to_another_country" , 
                     "m_onset_mig_move_within_city" , "m_onset_mig_move_to_another_city" , "m_onset_mig_move_to_another_country" , 
                     "n_onset_mig_move_within_city" , "n_onset_mig_move_to_another_city" , "n_onset_mig_move_to_another_country" , 
                     "i_onset_mig_move_within_city" , "i_onset_mig_move_to_another_city" , "i_onset_mig_move_to_another_country",
                     "status_mig" , "comments_mig" , "deviceid_mig" , "date_of_last_update_mig")

irle_cac <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_courtshipandcohabitation_table.csv")
names(irle_cac) <- c("id_cac" , "subjectID" , "assessmentId" , "test_taken_by_cac" , 
                     "m_recent_cac_become_engaged" , "m_recent_cac_break_cease_engagement" , "m_recent_cac_cease_steady_dating" , "m_recent_cac_increased_arguments_fiance" , 
                     "n_recent_cac_become_engaged" , "n_recent_cac_break_cease_engagement" , "n_recent_cac_cease_steady_dating" , "n_recent_cac_increased_arguments_fiance" , 
                     "i_recent_cac_become_engaged" , "i_recent_cac_break_cease_engagement" , "i_recent_cac_cease_steady_dating" , "i_recent_cac_increased_arguments_fiance" , 
                     "m_onset_cac_become_engaged" , "m_onset_cac_break_cease_engagement" , "m_onset_cac_cease_steady_dating" , "m_onset_cac_increased_arguments_fiance" , 
                     "n_onset_cac_become_engaged" , "n_onset_cac_break_cease_engagement" , "n_onset_cac_cease_steady_dating" , "n_onset_cac_increased_arguments_fiance" , 
                     "i_onset_cac_become_engaged" , "i_onset_cac_break_cease_engagement" , "i_onset_cac_cease_steady_dating" , "i_onset_cac_increased_arguments_fiance",
                     "status_cac" , "comments_cac" , "deviceid_cac" , "date_of_last_update_cac")

irle_lgl <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_legal_table.csv")
names(irle_lgl) <- c("id_lgl" , "subjectID" , "assessmentId" , "test_taken_by_lgl" , 
                     "m_recent_lgl_minor_violation" , "m_recent_lgl_important_violation" , "m_recent_lgl_jail_sentence" , "m_recent_lgl_lawsuit" , "m_recent_lgl_legal_problems_family" , 
                     "n_recent_lgl_minor_violation" , "n_recent_lgl_important_violation" , "n_recent_lgl_jail_sentence" , "n_recent_lgl_lawsuit" , "n_recent_lgl_legal_problems_family" , 
                     "i_recent_lgl_minor_violation" , "i_recent_lgl_important_violation" , "i_recent_lgl_jail_sentence" , "i_recent_lgl_lawsuit" , "i_recent_lgl_legal_problems_family" , 
                     "m_onset_lgl_minor_violation" , "m_onset_lgl_important_violation" , "m_onset_lgl_jail_sentence" , "m_onset_lgl_lawsuit" , "m_onset_lgl_legal_problems_family" , 
                     "n_onset_lgl_minor_violation" , "n_onset_lgl_important_violation" , "n_onset_lgl_jail_sentence" , "n_onset_lgl_lawsuit" , "n_onset_lgl_legal_problems_family" , 
                     "i_onset_lgl_minor_violation" , "i_onset_lgl_important_violation" , "i_onset_lgl_jail_sentence" , "i_onset_lgl_lawsuit" , "i_onset_lgl_legal_problems_family",
                     "status_lgl" , "comments_lgl" , "deviceid_lgl" , "date_of_last_update_lgl")

irle_oth <- read.csv("~/Documents/Projects/ADBS/DATA_QC/Scripts/irle/cambridge_others.csv")
names(irle_oth) <- c("id_oth" , "subjectID" , "assessmentId" , "test_taken_by_oth" , 
                     "m_recent_other" , "n_recent_other" , "i_recent_other" , 
                     "m_onset_other"  ,  "n_onset_other" ,   "i_onset_other" , 
                     "status_oth" , "comments_oth" , "deviceid_oth" , "date_of_last_update_oth")

# Iteratively merge all data.frames together
datalist = lapply(ls(pattern = "irle_"), get)
irle <- Reduce(function(x,y) {merge(x, y, all = TRUE)}, datalist)

# Check for subjects with incorrect subject/visit ID
irle_duplicates <- irle[nchar(irle$assessmentId) !=9 | 
                          irle$subjectID >170000 | irle$subjectID <110000 |
                          duplicated(irle$assessmentId, fromLast = T), ]

# Make a clean data frame after removing the rows from above two groups
irle <- irle[nchar(irle$assessmentId) ==9 & 
               irle$subjectID <170000 & irle$subjectID >110000 & 
               !duplicated(irle$assessmentId, fromLast = T), ]
irle <- irle[!is.na(irle$subjectID), ]

# IRLE scoring as per guidelines
irle$m_recent_work <- rowSums(irle[,grep("m_recent_wrk",names(irle))], na.rm=TRUE)
irle$n_recent_work <- rowSums(irle[,grep("n_recent_wrk",names(irle))], na.rm=TRUE)
irle$i_recent_work <- rowSums(irle[,grep("i_recent_wrk",names(irle))], na.rm=TRUE)
irle$m_onset_work <- rowSums(irle[,grep("m_onset_wrk",names(irle))], na.rm=TRUE)
irle$n_onset_work <- rowSums(irle[,grep("n_onset_wrk",names(irle))], na.rm=TRUE)
irle$i_onset_work <- rowSums(irle[,grep("i_onset_wrk",names(irle))], na.rm=TRUE)

irle$m_recent_education <- rowSums(irle[,grep("m_recent_edu",names(irle))], na.rm=TRUE)
irle$n_recent_education <- rowSums(irle[,grep("n_recent_edu",names(irle))], na.rm=TRUE)
irle$i_recent_education <- rowSums(irle[,grep("i_recent_edu",names(irle))], na.rm=TRUE)
irle$m_onset_education <- rowSums(irle[,grep("m_onset_edu",names(irle))], na.rm=TRUE)
irle$n_onset_education <- rowSums(irle[,grep("n_onset_edu",names(irle))], na.rm=TRUE)
irle$i_onset_education <- rowSums(irle[,grep("i_onset_edu",names(irle))], na.rm=TRUE)

irle$m_recent_financial <- rowSums(irle[,grep("m_recent_fin",names(irle))], na.rm=TRUE)
irle$n_recent_financial <- rowSums(irle[,grep("n_recent_fin",names(irle))], na.rm=TRUE)
irle$i_recent_financial <- rowSums(irle[,grep("i_recent_fin",names(irle))], na.rm=TRUE)
irle$m_onset_financial <- rowSums(irle[,grep("m_onset_fin",names(irle))], na.rm=TRUE)
irle$n_onset_financial <- rowSums(irle[,grep("n_onset_fin",names(irle))], na.rm=TRUE)
irle$i_onset_financial <- rowSums(irle[,grep("i_onset_fin",names(irle))], na.rm=TRUE)

irle$m_recent_health <- rowSums(irle[,grep("m_recent_hlt",names(irle))], na.rm=TRUE)
irle$n_recent_health <- rowSums(irle[,grep("n_recent_hlt",names(irle))], na.rm=TRUE)
irle$i_recent_health <- rowSums(irle[,grep("i_recent_hlt",names(irle))], na.rm=TRUE)
irle$m_onset_health <- rowSums(irle[,grep("m_onset_hlt",names(irle))], na.rm=TRUE)
irle$n_onset_health <- rowSums(irle[,grep("n_onset_hlt",names(irle))], na.rm=TRUE)
irle$i_onset_health <- rowSums(irle[,grep("i_onset_hlt",names(irle))], na.rm=TRUE)

irle$m_recent_bereavement <- rowSums(irle[,grep("m_recent_brv",names(irle))], na.rm=TRUE)
irle$n_recent_bereavement <- rowSums(irle[,grep("n_recent_brv",names(irle))], na.rm=TRUE)
irle$i_recent_bereavement <- rowSums(irle[,grep("i_recent_brv",names(irle))], na.rm=TRUE)
irle$m_onset_bereavement <- rowSums(irle[,grep("m_onset_brv",names(irle))], na.rm=TRUE)
irle$n_onset_bereavement <- rowSums(irle[,grep("n_onset_brv",names(irle))], na.rm=TRUE)
irle$i_onset_bereavement <- rowSums(irle[,grep("i_onset_brv",names(irle))], na.rm=TRUE)

irle$m_recent_migration <- rowSums(irle[,grep("m_recent_mig",names(irle))], na.rm=TRUE)
irle$n_recent_migration <- rowSums(irle[,grep("n_recent_mig",names(irle))], na.rm=TRUE)
irle$i_recent_migration <- rowSums(irle[,grep("i_recent_mig",names(irle))], na.rm=TRUE)
irle$m_onset_migration <- rowSums(irle[,grep("m_onset_mig",names(irle))], na.rm=TRUE)
irle$n_onset_migration <- rowSums(irle[,grep("n_onset_mig",names(irle))], na.rm=TRUE)
irle$i_onset_migration <- rowSums(irle[,grep("i_onset_mig",names(irle))], na.rm=TRUE)

irle$m_recent_courtship_cohabitation <- rowSums(irle[,grep("m_recent_cac",names(irle))], na.rm=TRUE)
irle$n_recent_courtship_cohabitation <- rowSums(irle[,grep("n_recent_cac",names(irle))], na.rm=TRUE)
irle$i_recent_courtship_cohabitation <- rowSums(irle[,grep("i_recent_cac",names(irle))], na.rm=TRUE)
irle$m_onset_courtship_cohabitation <- rowSums(irle[,grep("m_onset_cac",names(irle))], na.rm=TRUE)
irle$n_onset_courtship_cohabitation <- rowSums(irle[,grep("n_onset_cac",names(irle))], na.rm=TRUE)
irle$i_onset_courtship_cohabitation <- rowSums(irle[,grep("i_onset_cac",names(irle))], na.rm=TRUE)

irle$m_recent_legal <- rowSums(irle[,grep("m_recent_lgl",names(irle))], na.rm=TRUE)
irle$n_recent_legal <- rowSums(irle[,grep("n_recent_lgl",names(irle))], na.rm=TRUE)
irle$i_recent_legal <- rowSums(irle[,grep("i_recent_lgl",names(irle))], na.rm=TRUE)
irle$m_onset_legal <- rowSums(irle[,grep("m_onset_lgl",names(irle))], na.rm=TRUE)
irle$n_onset_legal <- rowSums(irle[,grep("n_onset_lgl",names(irle))], na.rm=TRUE)
irle$i_onset_legal <- rowSums(irle[,grep("i_onset_lgl",names(irle))], na.rm=TRUE)

irle$m_recent_family_social <- rowSums(irle[,grep("m_recent_fam",names(irle))], na.rm=TRUE)
irle$n_recent_family_social <- rowSums(irle[,grep("n_recent_fam",names(irle))], na.rm=TRUE)
irle$i_recent_family_social <- rowSums(irle[,grep("i_recent_fam",names(irle))], na.rm=TRUE)
irle$m_onset_family_social <- rowSums(irle[,grep("m_onset_fam",names(irle))], na.rm=TRUE)
irle$n_onset_family_social <- rowSums(irle[,grep("n_onset_fam",names(irle))], na.rm=TRUE)
irle$i_onset_family_social <- rowSums(irle[,grep("i_onset_fam",names(irle))], na.rm=TRUE)

irle$m_recent_marital <- rowSums(irle[,grep("m_recent_mar",names(irle))], na.rm=TRUE)
irle$n_recent_marital <- rowSums(irle[,grep("n_recent_mar",names(irle))], na.rm=TRUE)
irle$i_recent_marital <- rowSums(irle[,grep("i_recent_mar",names(irle))], na.rm=TRUE)
irle$m_onset_marital <- rowSums(irle[,grep("m_onset_mar",names(irle))], na.rm=TRUE)
irle$n_onset_marital <- rowSums(irle[,grep("n_onset_mar",names(irle))], na.rm=TRUE)
irle$i_onset_marital <- rowSums(irle[,grep("i_onset_mar",names(irle))], na.rm=TRUE)

write.csv(irle, "~/Documents/Projects/ADBS/DATA_QC/Scripts/IRLE.csv", row.names = F)
