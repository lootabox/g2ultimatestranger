
// https://forum.worldofplayers.de/forum/threads/1149697-Script-Eigene-Schadensberechnung?p=26502656&viewfull=1#post26502656

class oCVisualFX
{
//zCVob {
  //zCObject {
  var int    _vtbl;
  var int    _zCObject_refCtr;
  var int    _zCObject_hashIndex;
  var int    _zCObject_hashNext;
  var string _zCObject_objectName;
  //}
  var int    _zCVob_globalVobTreeNode;
  var int    _zCVob_lastTimeDrawn;
  var int    _zCVob_lastTimeCollected;
  var int    _zCVob_vobLeafList_array;
  var int    _zCVob_vobLeafList_numAlloc;
  var int    _zCVob_vobLeafList_numInArray;
  var int    _zCVob_trafoObjToWorld[16];
  var int    _zCVob_bbox3D_mins[3];
  var int    _zCVob_bbox3D_maxs[3];
  var int    _zCVob_bsphere3D_center[3];
  var int    _zCVob_bsphere3D_radius;
  var int    _zCVob_touchVobList_array;
  var int    _zCVob_touchVobList_numAlloc;
  var int    _zCVob_touchVobList_numInArray;
  var int    _zCVob_type;
  var int    _zCVob_groundShadowSizePacked;
  var int    _zCVob_homeWorld;
  var int    _zCVob_groundPoly;
  var int    _zCVob_callback_ai;
  var int    _zCVob_trafo;
  var int    _zCVob_visual;
  var int    _zCVob_visualAlpha;
  var int    _zCVob_m_fVobFarClipZScale;
  var int    _zCVob_m_AniMode;
  var int    _zCVob_m_aniModeStrength;
  var int    _zCVob_m_zBias;
  var int    _zCVob_rigidBody;
  var int    _zCVob_lightColorStat;
  var int    _zCVob_lightColorDyn;
  var int    _zCVob_lightDirectionStat[3];
  var int    _zCVob_vobPresetName;
  var int    _zCVob_eventManager;
  var int    _zCVob_nextOnTimer;
  var int    _zCVob_bitfield[5];
  var int    _zCVob_m_poCollisionObjectClass;
  var int    _zCVob_m_poCollisionObject;
  
//}

// public:
  var string	visName_S;
  var string	visSize_S;
  var int		  visAlpha;				// float
  var string	visAlphaBlendFunc_S;
  var int		  visTexAniFPS;			// float
  var int		  visTexAniIsLooping;
  var string	emTrjMode_S;
  var string  emTrjOriginNode_S;
  var string	emTrjTargetNode_S;
  var int		  emTrjTargetRange;		// float
  var int		  emTrjTargetAzi;		// float
  var int		  emTrjTargetElev;		// float
  var int		  emTrjNumKeys;
  var int		  emTrjNumKeysVar;
  var int		  emTrjAngleElevVar;	// float
  var int		  emTrjAngleHeadVar;	// float
  var int		  emTrjKeyDistVar;		// float
  var string	emTrjLoopMode_S;
  var string	emTrjEaseFunc_S;
  var int		  emTrjEaseVel;			// float
  var int		  emTrjDynUpdateDelay;	// float
  var int		  emTrjDynUpdateTargetOnly;
  var string	emFXCreate_S;
  var string	emFXInvestOrigin_S;
  var string	emFXInvestTarget_S;
  var int		  emFXTriggerDelay;		// float
  var int		  emFXCreatedOwnTrj;
  var string	emActionCollDyn_S;			// CREATE, BOUNCE, COLLIDE
  var string	emActionCollStat_S;			// CREATE, CREATEONCE, BOUNCE, COLLIDE, CREATEQUAD
  var string	emFXCollStat_S;
  var string	emFXCollDyn_S;
  var string	emFXCollDynPerc_S;
  var string	emFXCollStatAlign_S;			// TRAJECTORY, COLLISIONNORMAL
  var string	emFXCollDynAlign_S;
  var int		  emFXLifeSpan;			// float
  var int		  emCheckCollision;
  var int		  emAdjustShpToOrigin;
  var int		  emInvestNextKeyDuration;	// float
  var int		  emFlyGravity;				// float
  var string	emSelfRotVel_S;
  var string	userString[5];

  var string	lightPresetName;
  var string	sfxID;
  var int		  sfxIsAmbient;		// zBOOL
  var int		  sendAssessMagic;
  var int		  secsPerDamage;	// float

  var int		  dScriptEnd;		// zBYTE

  var int		  visSize[3];			// zVEC3
  var int		  emTrjMode;
  var int		  emActionCollDyn;
  var int		  emActionCollStat;
  var int		  emSelfRotVel[3]; // zVEC3
  var int		  emTrjEaseFunc; // enum TEaseFunc
  var int		  emTrjLoopMode; // enum TTrjLoopMode
  var int		  fxState; // enum zTVFXState

//  static zCParser*		fxParser;
//  static oCVisualFX*		actFX;

  var int root; // oCVisualFX*
  var int parent; 		// oCVisualFX*
  var int fxInvestOrigin; // oCVisualFX*
  var int fxInvestTarget; // oCVisualFX*
  var int ai;				// oCVisualFXAI*
//zCArray <oCVisualFX *> fxList {
  var int fxList_array;
  var int fxList_numAlloc;
  var int fxList_numInArray;
// }
//zCArray <oCVisualFX *> childList {
  var int childList_array;
  var int childList_numAlloc;
  var int childList_numInArray;
// }
//zCArray <oCEmitterKey *> emKeyList {
  var int emKeyList_array;
  var int emKeyList_numAlloc;
  var int emKeyList_numInArray;
// }
//zCArray <zCVob *> vobList {
  var int vobList_array;
  var int vobList_numAlloc;
  var int vobList_numInArray;
// }
//zCArray <zCVob *> ignoreVobList {
  var int ignoreVobList_array;
  var int ignoreVobList_numAlloc;
  var int ignoreVobList_numInArray;
// }
//zCArray <zCVob *> allowedCollisionVobList {
  var int allowedCollisionVobList_array;
  var int allowedCollisionVobList_numAlloc;
  var int allowedCollisionVobList_numInArray;
// }
//zCArray <zCVob *> collidedVobs {
  var int collidedVobs_array;
  var int collidedVobs_numAlloc;
  var int collidedVobs_numInArray;
// }
//zCArray <zSVisualFXColl> queuedCollisions {
  var int queuedCollisions_array;
  var int queuedCollisions_numAlloc;
  var int queuedCollisions_numInArray;
// }
// oCTrajectory trajectory {
	//zCArray <zCPositionKey *> keyList {
	  var int trajectory_keyList_array;
	  var int trajectory_keyList_numAlloc;
	  var int trajectory_keyList_numInArray;
	// }
  var int spl; // zCKBSpline*
  var int mode;
  var int length; // float
  // zMAT4 res {
    var int trajectory_res_v0[4]; //zREAL[4]
    var int trajectory_res_v1[4]; //zREAL[4]
    var int trajectory_res_v2[4]; //zREAL[4]
    var int trajectory_res_v3[4]; //zREAL[4]
  // }
  var int lastKey;
// }
  var int earthQuake;   // zCEarthquake*
  var int screenFX;     // zCVobScreenFX*
  var int screenFXTime; // float
  var int screenFXDir;
	
  var int orgNode;    // zCModelNodeInst*
  var int targetNode; // zCModelNodeInst*

  var int lastSetVisual;    // zCVisual*
  var int origin;           // zCVob*
  var int inflictor;        // zCVob*
  var int target;           // zCVob*
  var int light;            // zCVobLight*
  var int lightRange;       // float	
  var int sfx;              // zCSoundFX*
  var int sfxHnd;           // zTSoundHandle	

  var string fxName;

  var int fxBackup;   // oCEmitterKey*
  var int lastSetKey; // oCEmitterKey*
  var int actKey;     // oCEmitterKey*
  var int frameTime;      // float
  var int collisionTime;  // float
  var int deleteTime;     // float
  var int damageTime;     // float

  var int targetPos[3];     // zPOINT3
  var int lastTrjDir[3];    // zVEC3
  var int keySize[3];       // zVEC3
  var int actSize[3];       // zVEC3
  var int castEndSize[3];   // zVEC3

  var int nextLevelTime;    // float
  var int easeTime;         // float
  var int age;              // float
  var int trjUpdateTime;    // float
  var int emTrjDist;        // float
  var int trjSign;          // float
  var int levelTime;        // float
  var int lifeSpanTimer;    // float
  var int fxStartTime;      // float
  var int oldFovX, oldFovY; // float

// {
  // collisionOccured;           // zBOOL : 1
	
  // showVisual;                 // zBOOL : 1
  // isChild;                    // zBOOL : 1
  // isDeleted;                  // zBOOL : 1

  // initialized;                // zBOOL : 1
  // shouldDelete;               // zBOOL : 1
  // lightning;                  // zBOOL : 1
  // fxInvestOriginInitialized;  // zBOOL : 1
  // fxInvestTargetInitialized;  // zBOOL : 1
  // fxInvestStopped;            // zBOOL : 1
  // timeScaled;                 // zBOOL : 1
  // fovMorph;                   //       : 2
  // level;                      //       : 5
  // collisionCtr;               //       : 3
  // queueSetLevel;              //       : 5
  var int bitfield;
// }

// protected:
  var int damage;     // float
	var int damageType;

// private:
	var int spellType;
	var int spellCat;
	var int spellTargetTypes;

	var int savePpsValue;         // float
	var int saveVisSizeStart[2];  // zVEC2
  var int transRing_v0[3];      // zPOINT3
  var int transRing_v1[3];      // zPOINT3
  var int transRing_v2[3];      // zPOINT3
  var int transRing_v3[3];      // zPOINT3
  var int transRing_v4[3];      // zPOINT3
  var int transRing_v5[3];      // zPOINT3
  var int transRing_v6[3];      // zPOINT3
  var int transRing_v7[3];      // zPOINT3
  var int transRing_v8[3];      // zPOINT3
  var int transRing_v9[3];      // zPOINT3

	var int ringPos;
	var int emTrjFollowHitLastCheck;  // zBOOL
	var int bIsProjectile;            // zBOOL
	var int bPfxMeshSetByVisualFX;    // zBOOL
	var int m_bAllowMovement;         // zBOOL
	var int m_fSleepTimer;            // zREAL
};

func int oCVisualFX__GetLevel(var int _this) {
  // 00493150 => oCVisualFX::GetLevel
  CALL__thiscall(_this, 4796752);
  return CALL_RetValAsInt();
};