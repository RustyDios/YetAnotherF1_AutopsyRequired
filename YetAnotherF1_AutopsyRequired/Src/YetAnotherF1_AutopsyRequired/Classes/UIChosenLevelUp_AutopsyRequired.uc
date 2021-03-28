//---------------------------------------------------------------------------------------
//  FILE:    UIChosenLevelUp_AutopsyRequired.uc
//  AUTHOR:  RUSTYDIOS
//	
//	Created     26/01/21	08:30
//	Last Edit   26/01/21	09:00
//
//  PURPOSE: This file controls the Chosen Info screen on chosen LevelUp
//
//---------------------------------------------------------------------------------------

class UIChosenLevelUp_AutopsyRequired extends UIChosenLevelUp;

//parent vars of interest
//var string UnknownChosenTraitIcon;					= "img:///UILibrary_PerkIcons.UIPerk_unknown"

var localized string UnknownChosenTraitName;			//= "UNKNOWN"
var localized string UnknownChosenTraitDescription;     //= "-- ?? -- ?? --"
var localized string strForReveal;						//= " : FOR REVEAL"

var string strReason;									//= "REASON : X/Y"

var XComGameState_AdventChosen SelectedChosen;

//----------------------------------------------------------------------------
// MEMBERS
simulated function OnInit()
{
	local XComGameState_Unit UnitState;
	local XComGameState_AdventChosen ChosenUnitState;
	local XComGameState_HeadquartersAlien AlienHQ;

	//SelectedChosen = AlienHQ.GetChosenOfTemplate(class'XComGameState_Unit'.static.GetActivatedChosen().GetMyTemplateGroupName());
	//The above with error checking for safety;

	AlienHQ = XComGameState_HeadquartersAlien(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersAlien'));
	UnitState = class'XComGameState_Unit'.static.GetActivatedChosen();
	
	if (UnitState != none)
	{
		ChosenUnitState = AlienHQ.GetChosenOfTemplate(UnitState.GetMyTemplateGroupName());
		if (ChosenUnitState != none)
		{
			SelectedChosen = ChosenUnitState;
		}
	}

	//CALL THE BASE GAME FUNCTION CODE TOO, MAGIC !
	super.OnInit();
}

public function AS_UpdateData(
	string ChosenIcon,
	string ChosenLevel,
	string ChosenType,
	string ChosenName,
	string ChosenNickname,
	string Description,
	string StrengthTitle,
	string StrengthIcon,
	string StrengthValue,
	optional string WeaknessTitle,
	optional string WeaknessIcon,
	optional string WeaknessValue)
{
   	`LOG("========== STARTING YAF1AR CHOSEN LEVELUP CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

	MC.BeginFunctionOp("UpdateData");
	MC.QueueString(ChosenLevelUpTitle); //default text
	MC.QueueString(ChosenIcon);
	MC.QueueString(ChosenLevel);
	MC.QueueString(ChosenType);
	MC.QueueString(ChosenName);
	MC.QueueString(ChosenNickname);
	MC.QueueString(Description);

    //if it's blocked obfuscate
    if (class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(SelectedChosen, strReason) )
    {
   		//THIS IS ACTUALLY IF THE INFO SHOULD NOT SHOW 
		//... WE ONLY GET THIS FAR IF THE 'CONDITIONS' ARE TRUE
        strReason $= default.strForReveal;

        MC.QueueString(strReason);
        MC.QueueString("img:///UILibrary_PerkIcons.UIPerk_unknown");    //UnknownChosenTraitIcon
        MC.QueueString(UnknownChosenTraitName);
        MC.QueueString(UnknownChosenTraitDescription);
        MC.QueueString(strReason);
        MC.QueueString("img:///UILibrary_PerkIcons.UIPerk_unknown");    //UnknownChosenTraitIcon
        MC.QueueString(UnknownChosenTraitName);
        MC.QueueString(UnknownChosenTraitDescription);
        MC.QueueString(AbilityLabel);
        MC.QueueString(AbilityList);
    }
    else	//base game behaviour
    {
        MC.QueueString(StrengthsLabel);
        MC.QueueString(StrengthIcon);
        MC.QueueString(StrengthTitle);
        MC.QueueString(StrengthValue);
        MC.QueueString(WeaknessesLabel);
        MC.QueueString(WeaknessIcon);
        MC.QueueString(WeaknessTitle);
        MC.QueueString(WeaknessValue);
        MC.QueueString(AbilityLabel);
        MC.QueueString(AbilityList);
    }
	MC.EndOp();

   	`LOG("========== FINISHED YAF1AR CHOSEN LEVELUP CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
}
