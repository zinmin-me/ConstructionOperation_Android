import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const menuColor = Color.fromARGB(255, 60, 121, 233);

const defaultPadding = 16.0;
// IIS = 192.168.100.27:84
// localhost = localhost:50748
// server = 13.76.132.123:83

//Get
const getUser_url = 'http://13.76.132.123:83/ISOService.svc/GetUser?';

const getUserImageByUserID_url =
    'http://13.76.132.123:83/ISOService.svc/GetUserImageByUserID?';

const getAllProjectByUserID_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllProjectByUserID?';

const getAllMonthlyPlanBySiteIDAndPersonRole_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllMonthlyPlanBySiteIDAndPersonRole?';

const getAllMonthlyPlanByPersonIDAndPersonRole_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllMonthlyPlanByPersonIDAndPersonRole?';

const getAllMonthlyPlanDetailsBySiteIDAndForthemonth_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllMonthlyPlanDetailsBySiteIDAndForthemonth?';

const getAllMonthlyPlanBySiteIDAndForthemonth_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllMonthlyPlanBySiteIDAndForthemonth?';

const getMonthlyPlanBySiteIDAndForTheMonth_url =
    'http://13.76.132.123:83/ISOService.svc/GetMonthlyPlanBySiteIDAndForTheMonth?';

const getAllNameOfWorkByOPTypeID_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllNameOfWorkByOPTypeID?';

const getAllMonthlyPlanDetailsByMOPIDAndNameOfWorkID_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllMonthlyPlanDetailsByMOPIDAndNameOfWorkID?';

const getMonthlyPlanDetailsIDByMOPIDAndNameOfWorkID_url =
    'http://13.76.132.123:83/ISOService.svc/GetMonthlyPlanDetailsIDByMOPIDAndNameOfWorkID?';

const getAllPersonAndSiteBySiteIDAndPersonID_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllPersonAndSiteBySiteIDAndPersonID?';

const getAllPersonAndSiteByPersonID_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllPersonAndSiteByPersonID?';

const getAllPersonAndSiteBySiteIDAndResponsibilityTypeID_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllPersonAndSiteBySiteIDAndResponsibilityTypeID?';

const getAllResponsibilityTypeByType_url =
    'http://13.76.132.123:83/ISOService.svc/GetAllResponsibilityTypeByType?';

//Add
const addMonthlyPlan_url =
    'http://13.76.132.123:83/ISOService.svc/AddMonthlyPlan';

const addMonthlyPlanDetail_url =
    'http://13.76.132.123:83/ISOService.svc/AddMonthlyPlanDetail';

const addMonthlyPlanDetailByPlanDate_url =
    'http://13.76.132.123:83/ISOService.svc/AddMonthlyPlanDetailByPlanDate';

const addMonthlyPlanDetailByActualDate_url =
    'http://13.76.132.123:83/ISOService.svc/AddMonthlyPlanDetailByActualDate';

//Update
const updateMonthlyPlanStatusByMOPID_url =
    'http://13.76.132.123:83/ISOService.svc/UpdateMonthlyPlanStatusByMOPID?';

const updateMonthlyPlanStatusByMOPIDAndPersonRoleAndStatus_url =
    'http://13.76.132.123:83/ISOService.svc/UpdateMonthlyPlanStatusByMOPIDAndPersonRoleAndStatus?';

const updateMonthlyPlanDetail_url =
    'http://13.76.132.123:83/ISOService.svc/UpdateMonthlyPlanDetail';

const updateUser_url = 'http://13.76.132.123:83/ISOService.svc/UpdateUser?';

//Delete
const deleteMonthlyPlanBySiteIDAndForTheMonth_url =
    'http://13.76.132.123:83/ISOService.svc/DeleteMonthlyPlanBySiteIDAndForTheMonth?';

// //Get
// const getUser_url = 'http://localhost:50748/ISOService.svc/GetUser?';

//const getUserImageByUserID_url = 'http://localhost:50748/ISOService.svc/GetUserImageByUserID?';

// const getAllProjectByUserID_url =
//     'http://localhost:50748/ISOService.svc/GetAllProjectByUserID?';

// const getAllMonthlyPlanBySiteIDAndPersonRole_url =
//     'http://localhost:50748/ISOService.svc/GetAllMonthlyPlanBySiteIDAndPersonRole?';

// const getAllMonthlyPlanByPersonIDAndPersonRole_url =
//     'http://localhost:50748/ISOService.svc/GetAllMonthlyPlanByPersonIDAndPersonRole?';

// const getAllMonthlyPlanDetailsBySiteIDAndForthemonth_url =
//     'http://localhost:50748/ISOService.svc/GetAllMonthlyPlanDetailsBySiteIDAndForthemonth?';

// const getAllMonthlyPlanBySiteIDAndForthemonth_url =
//     'http://localhost:50748/ISOService.svc/GetAllMonthlyPlanBySiteIDAndForthemonth?';

// const getMonthlyPlanBySiteIDAndForTheMonth_url =
//     'http://localhost:50748/ISOService.svc/GetMonthlyPlanBySiteIDAndForTheMonth?';

// const getAllNameOfWorkByOPTypeID_url =
//     'http://localhost:50748/ISOService.svc/GetAllNameOfWorkByOPTypeID?';

// const getAllMonthlyPlanDetailsByMOPIDAndNameOfWorkID_url =
//     'http://localhost:50748/ISOService.svc/GetAllMonthlyPlanDetailsByMOPIDAndNameOfWorkID?';

// const getMonthlyPlanDetailsIDByMOPIDAndNameOfWorkID_url =
//     'http://localhost:50748/ISOService.svc/GetMonthlyPlanDetailsIDByMOPIDAndNameOfWorkID?';

// const getAllPersonAndSiteBySiteIDAndPersonID_url =
//     'http://localhost:50748/ISOService.svc/GetAllPersonAndSiteBySiteIDAndPersonID?';

// const getAllPersonAndSiteByPersonID_url =
//     'http://localhost:50748/ISOService.svc/GetAllPersonAndSiteByPersonID?';

// const getAllPersonAndSiteBySiteIDAndResponsibilityTypeID_url =
//     'http://localhost:50748/ISOService.svc/GetAllPersonAndSiteBySiteIDAndResponsibilityTypeID?';

// const getAllResponsibilityTypeByType_url =
//     'http://localhost:50748/ISOService.svc/GetAllResponsibilityTypeByType?';

// //Add
// const addMonthlyPlan_url =
//     'http://localhost:50748/ISOService.svc/AddMonthlyPlan';

// const addMonthlyPlanDetail_url =
//     'http://localhost:50748/ISOService.svc/AddMonthlyPlanDetail';

// const addMonthlyPlanDetailByPlanDate_url =
//     'http://localhost:50748/ISOService.svc/AddMonthlyPlanDetailByPlanDate';

// const addMonthlyPlanDetailByActualDate_url =
//     'http://localhost:50748/ISOService.svc/AddMonthlyPlanDetailByActualDate';

// //Update
// const updateMonthlyPlanStatusByMOPID_url =
//     'http://localhost:50748/ISOService.svc/UpdateMonthlyPlanStatusByMOPID?';

// const updateMonthlyPlanStatusByMOPIDAndPersonRoleAndStatus_url =
//     'http://localhost:50748/ISOService.svc/UpdateMonthlyPlanStatusByMOPIDAndPersonRoleAndStatus?';

// const updateMonthlyPlanDetail_url =
//     'http://localhost:50748/ISOService.svc/UpdateMonthlyPlanDetail';

// const updateUser_url = 'http://localhost:50748/ISOService.svc/UpdateUser?';

// //Delete
// const deleteMonthlyPlanBySiteIDAndForTheMonth_url =
//     'http://localhost:50748/ISOService.svc/DeleteMonthlyPlanBySiteIDAndForTheMonth?';
