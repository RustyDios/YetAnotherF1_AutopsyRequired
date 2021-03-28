//---------------------------------------------------------------------------------------
//  FILE:    UIChosenReveal_AutopsyRequired.uc
//  AUTHOR:  RUSTYDIOS
//
//	Created     25/01/21	00:00
//	Last Edit   26/01/21	04:00
//
//  PURPOSE: This file controls the Chosen Info screen for tactical reveal 
//	
//---------------------------------------------------------------------------------------
class UIChosenReveal_AutopsyRequired extends UIChosenReveal;

//parent vars of interest
//var localized string UnknownChosenTraitName;			= "UNKNOWN"
//var localized string UnknownChosenTraitDescription;	= "-- ?? -- ?? --"

//var string UnknownChosenTraitIcon;					= "img:///UILibrary_PerkIcons.UIPerk_unknown"

var localized string strForReveal;						//= " : FOR REVEAL"
var string strReason;									//= "REASON : X/Y : FOR REVEAL"

var XComGameState_AdventChosen SelectedChosen;

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

/*
//DECIDED AGAINST OBSCURING THIS
function SetWeaknessFaction(string RivalFactionName)
{
	MC.BeginFunctionOp("SetWeaknessFaction");
	MC.QueueString(RivalFactionTitle);
	MC.QueueString(RivalFactionName);
	MC.EndOp();
}
*/

function SetStrengthData(int StrengthIndex, string StrengthIconPath, string StrengthName, string StrengthDescription)
{
   	`LOG("========== STARTING YAF1AR CHOSEN REV STR CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

	MC.BeginFunctionOp("SetStrengthData");
	MC.QueueNumber(StrengthIndex);

    if (class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(SelectedChosen, strReason) )
	{
		//THIS IS ACTUALLY IF THE INFO SHOULD NOT SHOW 
		//... WE ONLY GET THIS FAR IF THE 'CONDITIONS' ARE TRUE
        MC.QueueString(UnknownChosenTraitIcon);
        MC.QueueString(UnknownChosenTraitName);
        MC.QueueString(UnknownChosenTraitDescription);
	}
    else	//base game behaviour
    {
        MC.QueueString(StrengthIconPath);
        MC.QueueString(StrengthName);
        MC.QueueString(StrengthDescription);
    }

	MC.EndOp();

   	`LOG("========== FINISHED YAF1AR CHOSEN REV STR CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
}

function SetWeaknessData(int WeaknessIndex, string WeaknessIconPath, string WeaknessName, string WeaknessDescription, bool WeaknessesDisabled)
{
   	`LOG("========== STARTING YAF1AR CHOSEN REV WKN CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

	MC.BeginFunctionOp("SetWeaknessData");
	MC.QueueNumber(WeaknessIndex);

    if (class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(SelectedChosen, strReason) )
	{
		//THIS IS ACTUALLY IF THE INFO SHOULD NOT SHOW 
		//... WE ONLY GET THIS FAR IF THE 'CONDITIONS' ARE TRUE
        MC.QueueString(UnknownChosenTraitIcon);
        MC.QueueString(UnknownChosenTraitName);
        MC.QueueString(UnknownChosenTraitDescription);
	}
    else	//base game behaviour
    {
        MC.QueueString(WeaknessIconPath);
        MC.QueueString(WeaknessName);
        MC.QueueString(WeaknessDescription);
    }

	MC.QueueBoolean(WeaknessesDisabled);
	MC.EndOp();

   	`LOG("========== FINISHED YAF1AR CHOSEN REV WKN CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
}

function SetTitles()
{
   	`LOG("========== STARTING YAF1AR CHOSEN REV TITLE CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');

    //strReason here will be the same string that shows up on the YAF1 screen, either ENCOUNTER: x/y OR HUNT PROGRESS: a/b
    //failing those two responses it will default to "", blank
    if (class'X2EventListener_AutopsyRequired'.static.CheckChosenInfoBlocked(SelectedChosen, strReason) )
	{
		//THIS IS ACTUALLY IF THE INFO SHOULD NOT SHOW 
		//... WE ONLY GET THIS FAR IF THE 'CONDITIONS' ARE TRUE
		strReason $= default.strForReveal;

        MC.FunctionString("SetStrengthTitle", strReason);
        MC.FunctionString("SetWeaknessTitle", strReason);
    }
    else	//base game behaviour
    {
        MC.FunctionString("SetStrengthTitle", ChosenStrengthTitle);
        MC.FunctionString("SetWeaknessTitle", ChosenWeaknessTitle);
    }

   	`LOG("========== FINISHED YAF1AR CHOSEN REV TITLE CHECK ==========", class'X2EventListener_AutopsyRequired'.default.bEnableLog, 'YAF1_AutopsyRequired');
}
