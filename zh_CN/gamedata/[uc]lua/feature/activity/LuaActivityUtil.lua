
LuaActivityUtil = ModelMgr.DefineModel("LuaActivityUtil")

local eutils = CS.Torappu.Lua.Util

function LuaActivityUtil:OnInit()
  CS.Torappu.UI.LuaActivityUtil.BindInterface(self)
end

function LuaActivityUtil:OnDispose()
  CS.Torappu.UI.LuaActivityUtil.BindInterface(nil)
end

local HOME_WEIGHT_DAILY_PRAY = 500;
local HOME_WEIGHT_GRID_GACHA = 510;
local HOME_WEIGHT_GRID_GACHA_V2 = 520;
local HOME_WEIGHT_FLOAT_PARADE = 530;
local HOME_WEIGHT_DAILY_FLIP = 540;
local HOME_WEIGHT_CHECKIN_ALLPLAYER = 550;

local HOME_WEIGHT_MAIN_BUFF = 600;



local function _FindValidPrayOnlyActs(validActs, uncompleteActs)
  local actList = CS.Torappu.UI.ActivityUtil.FindValidPrayOnlyActs()
  if actList == nil then
    return
  end
  for i = 0, actList.Count - 1 do 
    local actId = actList[i]
    local validAct = CS.Torappu.SortableString(actId, HOME_WEIGHT_DAILY_PRAY)
    validActs:Add(validAct)
    if CS.Torappu.UI.ActivityUtil.CheckIfPrayOnlyActUncomplete(actId) then
      uncompleteActs:Add(validAct)
    end
  end
end



function LuaActivityUtil:_FindValidFlipOnlyActs(validActs, uncompleteActs)
  local actList = CS.Torappu.UI.ActivityUtil.FindValidFlipOnlyActs()
  if actList == nil then
    return
  end
  for i = 0, actList.Count - 1 do 
    local actId = actList[i]
    local validAct = CS.Torappu.SortableString(actId, HOME_WEIGHT_DAILY_FLIP)
    validActs:Add(validAct)
    if self:CheckIfActivityUncomplete(CS.Torappu.ActivityType.FLIP_ONLY, actId) then
      uncompleteActs:Add(validAct);
    end
  end
end



local function _FindValidGridGachaActs(validActs, uncompleteActs)
  local actList = CS.Torappu.UI.ActivityUtil.FindValidGridGachaActs()
  if actList == nil then
    return
  end
  for i = 0, actList.Count - 1 do
    local actId = actList[i]
    local validAct = CS.Torappu.SortableString(actId, HOME_WEIGHT_GRID_GACHA)
    validActs:Add(validAct)
    if CS.Torappu.UI.ActivityUtil.CheckIfGridGachaActUncomplete(actId) then
      uncompleteActs:Add(validAct)
    end
  end
end



function LuaActivityUtil:_FindValidGridGachaV2Acts(validActs, uncompleteActs)
  local actList = {};

  local actList = CS.Torappu.UI.ActivityUtil.FindValidActs(CS.Torappu.ActivityType.GRID_GACHA_V2);
  if actList == nil then
    return;
  end
  for i = 0, actList.Count - 1 do
    local actId = actList[i];
    local validAct = CS.Torappu.SortableString(actId, HOME_WEIGHT_GRID_GACHA_V2);
    validActs:Add(validAct);
    if self:CheckIfActivityUncomplete(CS.Torappu.ActivityType.GRID_GACHA_V2, actId) then
      uncompleteActs:Add(validAct);
    end
  end
end



function LuaActivityUtil:_FindValidFloatParadeAct(validActs, uncompleteActs)
  local actList = CS.Torappu.UI.ActivityUtil.FindValidActs(CS.Torappu.ActivityType.FLOAT_PARADE);
  if actList == nil then
    return;
  end

  for i = 0, actList.Count - 1 do
    local actId = actList[i];
    local validAct = CS.Torappu.SortableString(actId, HOME_WEIGHT_FLOAT_PARADE);
    validActs:Add(validAct);
    if self:_CheckIfFloatParadeUncomplete(actId) then
      uncompleteActs:Add(validAct);
    end
  end

end



function LuaActivityUtil:_FindValidMainlineBuffAct(validActs, uncompleteActs)
  local actList = CS.Torappu.UI.ActivityUtil.FindValidActs(CS.Torappu.ActivityType.MAIN_BUFF);
  if actList == nil then
    return;
  end

  for i = 0, actList.Count - 1 do
    local actId = actList[i];
    local validAct = CS.Torappu.SortableString(actId, HOME_WEIGHT_MAIN_BUFF);
    validActs:Add(validAct);
    if self:CheckIfActivityUncomplete(CS.Torappu.ActivityType.MAIN_BUFF, actId) then
      uncompleteActs:Add(validAct);
    end
  end
end

function LuaActivityUtil:_FindValidCheckinAllActs(validActs, uncompleteActs)
  local actList = CS.Torappu.UI.ActivityUtil.FindValidActs(CS.Torappu.ActivityType.CHECKIN_ALL_PLAYER);
  if actList == nil then
    return;
  end

  for i = 0, actList.Count - 1 do
    local actId = actList[i];
    local validAct = CS.Torappu.SortableString(actId, HOME_WEIGHT_CHECKIN_ALLPLAYER);
    validActs:Add(validAct);
    if self:_CheckIfCheckinAllUncomplete(actId) then
      uncompleteActs:Add(validAct);
    end
  end
end




function LuaActivityUtil:FindValidHomeActs(validActs, uncompleteActs)
  
  _FindValidPrayOnlyActs(validActs, uncompleteActs)
  _FindValidGridGachaActs(validActs, uncompleteActs)
  self:_FindValidFlipOnlyActs(validActs, uncompleteActs)
  self:_FindValidGridGachaV2Acts(validActs, uncompleteActs);
  self:_FindValidFloatParadeAct(validActs, uncompleteActs);
  self:_FindValidMainlineBuffAct(validActs, uncompleteActs);
  self:_FindValidCheckinAllActs(validActs, uncompleteActs);
end


local DEFINE_CLS_FUNCS = {
  COLLECTION = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, CollectionMainDlg)
  end,
  LOGIN_ONLY = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, LoginOnlyDlg)
  end,
  PRAY_ONLY = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, PrayOnlyMainDlg)
  end,
  GRID_GACHA = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, GridGachaMainDlg)
  end,
  GRID_GACHA_V2 = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, GridGachaV2MainDlg)
  end,
  FLOAT_PARADE = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, FloatParadeMainDlg)
  end,
  MAIN_BUFF = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, MainlineBuffMainDlg)
  end,
  FLIP_ONLY = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, ActFlipMainDlg)
  end,
  CHECKIN_ALL_PLAYER = function(clsName, config)
    DlgMgr.DefineDialog(clsName, config.dlgPath, CheckinAllPlayerMainDlg)
  end,
}






local function _DefineActDialogCls(clsName, config)
  local overrideBaseCls = config.overrideBaseCls
  if overrideBaseCls ~= nil and overrideBaseCls ~= "" then
    
    local baseCls = DlgMgr.GetDialogCls(overrideBaseCls)
    if baseCls == nil then
      eutils.LogError("Couldn't find lua cls " .. overrideBaseCls)
      return false
    end
    DlgMgr.DefineDialog(clsName, config.dlgPath, baseCls)
    return true
  end
  
  local createFunc = DEFINE_CLS_FUNCS[config.actType]
  if createFunc == nil then
    return false
  end
  createFunc(clsName, config)
  return true
end



function LuaActivityUtil:EnsureActivityDialogClass(config)
  local targetClsName = eutils.Format("{0}Dlg", string.upper(config.actId))
  local existCls = DlgMgr.GetDialogCls(targetClsName)
  if existCls ~= nil then
    return targetClsName
  end
  
  if _DefineActDialogCls(targetClsName, config) then
    return targetClsName
  end

  return nil
end




function LuaActivityUtil:CheckIfActivityUncomplete(type, actId)
  if type == nil or actId == nil then
    return false;
  end
  
  if type == CS.Torappu.ActivityType.GRID_GACHA_V2 then
    return self:_CheckIfGridGachaV2Uncomplete(actId);
  elseif type == CS.Torappu.ActivityType.FLOAT_PARADE then
    return self:_CheckIfFloatParadeUncomplete(actId);
  elseif type == CS.Torappu.ActivityType.MAIN_BUFF then
    return self:_CheckIfMainlineBuffUncomplete(actId);
  elseif type == CS.Torappu.ActivityType.FLIP_ONLY then
    return self:_CheckIfFlipUncomplete(actId);
  elseif type == CS.Torappu.ActivityType.CHECKIN_ALL_PLAYER then
    return self:_CheckIfCheckinAllUncomplete(actId);
  else
    return false;
  end
end

function LuaActivityUtil:_CheckIfGridGachaV2Uncomplete(actId)
  local actList = CS.Torappu.PlayerData.instance.data.activity.gridGachaV2ActivityList;
  if actList == nil then
    return false;
  end
  local success, actData = actList:TryGetValue(actId);
  if not success then
    return false;
  end
  local data = eutils.ConvertJObjectToLuaTable(actData);
  return data.today.done == 0;
end

function LuaActivityUtil:_CheckIfFloatParadeUncomplete(actId)
  local floatParades = CS.Torappu.PlayerData.instance.data.activity.floatParadeActivityList;
  if floatParades == nil then
    return false;
  end
  local suc, playerActData = floatParades:TryGetValue(actId);
  if not suc then
    return false;
  end
  return playerActData.canRaffle;
end

function LuaActivityUtil:_CheckIfMainlineBuffUncomplete(actId)
  if actId == nil or actId == "" then
    return false;
  end

  local actList = CS.Torappu.PlayerData.instance.data.activity.mainlineBuffActivityList;
  if actList == nil then
    return false;
  end
  local success, actData = actList:TryGetValue(actId);
  if not success then
    return false;
  end

  if MainlineBuffUtil.CheckIfMissionGroupNeedComplete(actId) then
    return true;
  end

  local periodId = MainlineBuffUtil.GetCurrMainlineBuffActPeriodId(actId);
  return MainlineBuffUtil.IsPeriodChecked(actId, periodId);
end

function LuaActivityUtil:_CheckIfCheckinAllUncomplete(actId)
  local checkinAllPlayers = CS.Torappu.PlayerData.instance.data.activity.checkinAllActivityList;
  if checkinAllPlayers == nil then
    return false;
  end
  local suc, playerActData = checkinAllPlayers:TryGetValue(actId);
  if not suc then
    return false;
  end
  for pubBhvId, bhvStatus in pairs(playerActData.allRewardStatus) do
    if bhvStatus == CheckinAllPlayerRewardStatus.AVAILABLE then
      return true;
    end
  end

  for idx = 0, playerActData.history.Count -1 do
    local status = playerActData.history[idx];
    if status == CheckinAllPlayerRewardStatus.AVAILABLE then
      return true;
    end
  end
  return false;
end

function LuaActivityUtil:_CheckIfFlipUncomplete(actId)
  local actList = CS.Torappu.PlayerData.instance.data.activity.flipOnlyActivityList;
  if actList == nil then
    return false;
  end
  local success, actData = actList:TryGetValue(actId);
  if not success then
    return false;
  end
  return (actData.remainingRaffleCount > 0) or (actData.grandStatus == 1);
end