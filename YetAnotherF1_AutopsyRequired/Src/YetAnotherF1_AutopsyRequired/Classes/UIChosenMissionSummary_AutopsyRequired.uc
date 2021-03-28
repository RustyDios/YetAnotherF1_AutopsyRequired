//---------------------------------------------------------------------------------------
//  FILE:    UIChosenMissionSummary_AutopsyRequired.uc
//  AUTHOR:  RUSTYDIOS
//	
//	Created     26/01/21	08:30
//	Last Edit   26/01/21	09:00
//
//  PURPOSE: This file controls the Chosen Info screen on post mission
//
//---------------------------------------------------------------------------------------
class UIChosenMissionSummary_AutopsyRequired extends UIChosenMissionSummary;

//parent vars of interest
//var XComGameState_AdventChosen ChosenState;

//var localized string StrengthsLabel;
//var localized string WeaknessesLabel;

var localized string UnknownChosenTraitDescription;     //= "-- ?? -- ?? --"
var localized string strForReveal;						//= " : FOR REVEAL"

var string strReason;									//= "REASON : X/Y"

//---------------------------------------------------------------------------------------
simulated function SetChosenData()
{
   	`LOG("========== STARTING YAF1AR CHOSEN MISSION CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

	MC.BeginFunctionOp("SetChosenData");
	MC.QueueString(ChosenEncounterTitle);
	MC.QueueString(ChosenEncounterSubtitle);
	MC.QueueString(ChosenState.GetChosenClassName());
	MC.QueueString(ChosenState.GetChosenName());
	MC.QueueString(ChosenState.GetChosenNickname());
	MC.QueueString(ChosenState.GetChosenNarrativeFlavor());

    //if it's blocked obfuscate
    if (class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(ChosenState, strReason) )
    {
   		//THIS IS ACTUALLY IF THE INFO SHOULD NOT SHOW 
		//... WE ONLY GET THIS FAR IF THE 'CONDITIONS' ARE TRUE
        strReason $= default.strForReveal;

        MC.QueueString(strReason);
        MC.QueueString(UnknownChosenTraitDescription);
        MC.QueueString(strReason);
        MC.QueueString(UnknownChosenTraitDescription);
    }
    else    //base game behaviour
    {
        MC.QueueString(StrengthsLabel);
        MC.QueueString(ChosenState.GetStrengthsList());
        MC.QueueString(WeaknessesLabel);
        MC.QueueString(ChosenState.GetWeaknessesList());
    }

	MC.EndOp();

   	`LOG("========== FINISHED YAF1AR CHOSEN LEVELUP CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
}
