(()=>{var x=e=>new Promise(a=>setTimeout(a,e)),C=e=>{let a=GetEntityModel(e),t=GetHashKey("mp_m_freemode_01"),r=GetHashKey("mp_f_freemode_01");return a===t||a===r},g=e=>{let a=GetEntityModel(e),t=GetHashKey("mp_m_freemode_01");return a===t};function v(e){return{x:e[0],y:e[1],z:e[2]}}var O=[0,1,2,3,4,5,6,7,8,9,10,11],B=[0,1,2,6,7],F=["noseWidth","nosePeakHigh","nosePeakSize","noseBoneHigh","nosePeakLowering","noseBoneTwist","eyeBrownHigh","eyeBrownForward","cheeksBoneHigh","cheeksBoneWidth","cheeksWidth","eyesOpening","lipsThickness","jawBoneWidth","jawBoneBackSize","chinBoneLowering","chinBoneLenght","chinBoneSize","chinHole","neckThickness"],S=["blemishes","beard","eyebrows","ageing","makeUp","blush","complexion","sunDamage","lipstick","moleAndFreckles","chestHair","bodyBlemishes"],de=["Green","Emerald","Light Blue","Ocean Blue","Light Brown","Dark Brown","Hazel","Dark Gray","Light Gray","Pink","Yellow","Purple","Blackout","Shades of Gray","Tequila Sunrise","Atomic","Warp","ECola","Space Ranger","Ying Yang","Bullseye","Lizard","Dragon","Extra Terrestrial","Goat","Smiley","Possessed","Demon","Infected","Alien","Undead","Zombie"];var _e={ped:!0,headBlend:!0,faceFeatures:!0,headOverlays:!0,components:!0,componentConfig:{masks:!0,upperBody:!0,lowerBody:!0,bags:!0,shoes:!0,scarfAndChains:!0,shirts:!0,bodyArmor:!0,decals:!0,jackets:!0},props:!0,propConfig:{hats:!0,glasses:!0,ear:!0,watches:!0,bracelets:!0},tattoos:!0,enableExit:!0},q={head:{animations:{on:{dict:"mp_masks@standard_car@ds@",anim:"put_on_mask",move:51,duration:600},off:{dict:"missheist_agency2ahelmet",anim:"take_off_helmet_stand",move:51,duration:1200}},props:{male:[[1,0]],female:[[1,0]]}},body:{animations:{on:{dict:"clothingtie",anim:"try_tie_negative_a",move:51,duration:1200},off:{dict:"clothingtie",anim:"try_tie_negative_a",move:51,duration:1200}},props:{male:[[11,252],[3,15],[8,15],[10,0],[5,0]],female:[[11,15],[8,14],[3,15],[10,0],[5,0]]}},bottom:{animations:{on:{dict:"re@construction",anim:"out_of_breath",move:51,duration:1300},off:{dict:"re@construction",anim:"out_of_breath",move:51,duration:1300}},props:{male:[[4,61],[6,34]],female:[[4,15],[6,35]]}}};function ue(){RegisterNuiCallbackType("appearance_get_locales"),RegisterNuiCallbackType("appearance_get_settings_and_data"),RegisterNuiCallbackType("appearance_set_camera"),RegisterNuiCallbackType("appearance_turn_around"),RegisterNuiCallbackType("appearance_rotate_camera"),RegisterNuiCallbackType("appearance_change_model"),RegisterNuiCallbackType("appearance_change_head_blend"),RegisterNuiCallbackType("appearance_change_face_feature"),RegisterNuiCallbackType("appearance_change_hair"),RegisterNuiCallbackType("appearance_change_head_overlay"),RegisterNuiCallbackType("appearance_change_eye_color"),RegisterNuiCallbackType("appearance_change_component"),RegisterNuiCallbackType("appearance_change_prop"),RegisterNuiCallbackType("appearance_apply_tattoo"),RegisterNuiCallbackType("appearance_preview_tattoo"),RegisterNuiCallbackType("appearance_delete_tattoo"),RegisterNuiCallbackType("appearance_wear_clothes"),RegisterNuiCallbackType("appearance_remove_clothes"),RegisterNuiCallbackType("appearance_save"),RegisterNuiCallbackType("appearance_exit"),RegisterNuiCallbackType("rotate_left"),RegisterNuiCallbackType("rotate_right"),RegisterNuiCallbackType("get_theme_configuration"),on("__cfx_nui:appearance_get_locales",(e,a)=>{a(Ce)}),on("__cfx_nui:appearance_get_settings_and_data",async(e,a)=>{emitNet("fivem-appearance:server:GetPlayerAces"),await x(250);let t=ye(),r=Q(),o=Y();a({config:t,appearanceData:r,appearanceSettings:o})}),on("__cfx_nui:appearance_set_camera",(e,a)=>{a({}),ae(e)}),on("__cfx_nui:appearance_turn_around",(e,a)=>{a({}),D(PlayerPedId(),180)}),on("__cfx_nui:appearance_rotate_camera",(e,a)=>{a({}),me(e)}),on("__cfx_nui:appearance_change_model",async(e,a)=>{await L(e);let t=PlayerPedId();SetEntityHeading(PlayerPedId(),$),SetEntityInvincible(t,!0),TaskStandStill(t,-1);let r=b(t),o=Y();a({appearanceSettings:o,appearanceData:r})}),on("__cfx_nui:appearance_change_component",(e,a)=>{let t=PlayerPedId();z(t,e),a(X(t,e.component_id))}),on("__cfx_nui:appearance_change_prop",(e,a)=>{let t=PlayerPedId();V(t,e),a(ee(t,e.prop_id))}),on("__cfx_nui:appearance_change_head_blend",(e,a)=>{a({}),M(PlayerPedId(),e)}),on("__cfx_nui:appearance_change_face_feature",(e,a)=>{a({}),k(PlayerPedId(),e)}),on("__cfx_nui:appearance_change_head_overlay",(e,a)=>{a({}),G(PlayerPedId(),e)}),on("__cfx_nui:appearance_change_hair",(e,a)=>{let t=PlayerPedId();N(t,e),a(pe(t,e))}),on("__cfx_nui:appearance_change_eye_color",(e,a)=>{a({}),T(PlayerPedId(),e)}),on("__cfx_nui:appearance_apply_tattoo",(e,a)=>{a({}),ge(PlayerPedId(),e)}),on("__cfx_nui:appearance_preview_tattoo",(e,a)=>{a({});let{data:t,tattoo:r}=e;he(PlayerPedId(),t,r)}),on("__cfx_nui:appearance_delete_tattoo",(e,a)=>{a({}),ve(PlayerPedId(),e)}),on("__cfx_nui:appearance_wear_clothes",(e,a)=>{a({});let{data:t,key:r}=e;Pe(t,r)}),on("__cfx_nui:appearance_remove_clothes",(e,a)=>{a({}),fe(e)}),on("__cfx_nui:appearance_save",(e,a)=>{a({}),Z(e)}),on("__cfx_nui:appearance_exit",(e,a)=>{a({}),Z()}),on("__cfx_nui:rotate_left",(e,a)=>{a({}),D(PlayerPedId(),10)}),on("__cfx_nui:rotate_right",(e,a)=>{a({}),D(PlayerPedId(),-10)}),on("__cfx_nui:get_theme_configuration",(e,a)=>{a(xe)})}var ze=global.exports,be={default:{coords:{x:0,y:2.2,z:.2},point:{x:0,y:0,z:-.05}},head:{coords:{x:0,y:.9,z:.65},point:{x:0,y:0,z:.6}},body:{coords:{x:0,y:1.2,z:.2},point:{x:0,y:0,z:.2}},bottom:{coords:{x:0,y:.98,z:-.7},point:{x:0,y:0,z:-.9}}},Ve={default:{x:1.5,y:-1},head:{x:.7,y:-.45},body:{x:1.2,y:-.45},bottom:{x:.7,y:-.45}},U,te,A,w,$,m,I,H,h,He={};function Fe(){let e={hair:[],makeUp:[]};for(let a=0;a<GetNumHairColors();a++)e.hair.push(GetPedHairRgbColor(a));for(let a=0;a<GetNumMakeupColors();a++)e.makeUp.push(GetMakeupRgbColor(a));return e}function Q(){return A||(A=b(PlayerPedId())),A}function Ue(e,a,t,r){if(a===t&&e.textures!==void 0)for(let o=0;o<e.textures.length;o++)r.textures.push(e.textures[o]);(e.textures===void 0||e.textures.length===0)&&r.drawables.push(a)}function je(e){let a=[],t=re(),r=ne(),o=ie();for(let n=0;n<e.length;n++){let i=e[n];(!i.jobs&&!i.gangs&&!i.aces||i.jobs&&i.jobs.includes(t)||i.gangs&&i.gangs.includes(r)||i.aces&&i.aces.some(l=>o.includes(l)))&&a.push(...i.peds)}return a}function Se(e,a){var t={drawables:[],textures:[]};let r=re(),o=ne(),n=ie();for(let i=0;i<e.length;i++){let l=e[i];if(!(l.jobs&&l.jobs.includes(r)||l.gangs&&l.gangs.includes(o)||l.aces&&l.aces.some(s=>n.includes(s)))&&l.drawables)for(let s=0;s<l.drawables.length;s++)Ue(l,l.drawables[s],a,t)}return t}function We(e,a){let t=E.male.components;switch(e||(t=E.female.components),a){case 1:return t.masks;case 3:return t.upperBody;case 4:return t.lowerBody;case 5:return t.bags;case 6:return t.shoes;case 7:return t.scarfAndChains;case 8:return t.shirts;case 9:return t.bodyArmor;case 10:return t.decals;case 11:return t.jackets;default:break}return[]}function Ke(e,a){let t=E.male.props;switch(e||(t=E.female.props),a){case 0:return t.hats;case 1:return t.glasses;case 2:return t.ear;case 6:return t.watches;case 7:return t.bracelets;default:break}return[]}function X(e,a){let t=GetPedDrawableVariation(e,a),r=g(e);var o={drawables:[],textures:[]};return C(e)&&(o=Se(We(r,a),t)),{component_id:a,drawable:{min:0,max:GetNumberOfPedDrawableVariations(e,a)-1},texture:{min:0,max:GetNumberOfPedTextureVariations(e,a,t)-1},blacklist:o}}function ee(e,a){let t=GetPedPropIndex(e,a),r=g(e);var o={drawables:[],textures:[]};return C(e)&&(o=Se(Ke(r,a),t)),{prop_id:a,drawable:{min:-1,max:GetNumberOfPedPropDrawableVariations(e,a)-1},texture:{min:-1,max:GetNumberOfPedPropTextureVariations(e,a,t)-1},blacklist:o}}function pe(e,a){let t=Fe();return{style:{min:0,max:GetNumberOfPedDrawableVariations(e,2)-1},color:{items:t.hair},highlight:{items:t.hair},texture:{min:0,max:GetNumberOfPedTextureVariations(e,2,a.style)-1}}}function Y(){let e=PlayerPedId(),a={model:{items:je(j.pedConfig)}},t={items:ke},r=O.map(p=>X(e,p)),o=B.map(p=>ee(e,p)),n={shapeFirst:{min:0,max:45},shapeSecond:{min:0,max:45},shapeThird:{min:0,max:45},skinFirst:{min:0,max:45},skinSecond:{min:0,max:45},skinThird:{min:0,max:45},shapeMix:{min:0,max:1,factor:.1},skinMix:{min:0,max:1,factor:.1},thirdMix:{min:0,max:1,factor:.1}},i=F.reduce((p,_)=>({...p,[_]:{min:-1,max:1,factor:.1}}),{}),l=Fe(),s={beard:l.hair,eyebrows:l.hair,chestHair:l.hair,makeUp:l.makeUp,blush:l.makeUp,lipstick:l.makeUp},c=S.reduce((p,_,f)=>{let P={style:{min:0,max:GetPedHeadOverlayNum(f)-1},opacity:{min:0,max:1,factor:.1}};return s[_]&&Object.assign(P,{color:{items:s[_]}}),{...p,[_]:P}},{}),d={style:{min:0,max:GetNumberOfPedDrawableVariations(e,2)-1},color:{items:l.hair},highlight:{items:l.hair},texture:{min:0,max:GetNumberOfPedTextureVariations(e,2,GetPedDrawableVariation(e,2))-1}};return{ped:a,components:r,props:o,headBlend:n,faceFeatures:i,headOverlays:c,hair:d,eyeColor:{min:0,max:30},tattoos:t}}function ye(){return te}function ae(e){if(h)return;e!=="current"&&(I=e);let{coords:a,point:t}=be[I],r=H?-1:1;if(m){let o=v(GetOffsetFromEntityInWorldCoords(PlayerPedId(),a.x*r,a.y*r,a.z)),n=v(GetOffsetFromEntityInWorldCoords(PlayerPedId(),t.x,t.y,t.z)),i=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",o.x,o.y,o.z,0,0,0,49,!1,0);PointCamAtCoord(i,n.x,n.y,n.z),SetCamActiveWithInterp(i,m,1e3,1,1),h=!0;let l=setInterval(()=>{!IsCamInterpolating(m)&&IsCamActive(i)&&(DestroyCam(m,!1),m=i,h=!1,clearInterval(l))},500)}else{let o=v(GetOffsetFromEntityInWorldCoords(PlayerPedId(),a.x,a.y,a.z)),n=v(GetOffsetFromEntityInWorldCoords(PlayerPedId(),t.x,t.y,t.z));m=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",o.x,o.y,o.z,0,0,0,49,!1,0),PointCamAtCoord(m,n.x,n.y,n.z),SetCamActive(m,!0)}}async function me(e){if(h)return;let{coords:a,point:t}=be[I],r=Ve[I],o,n=H?-1:1;e==="left"?o=1:e==="right"&&(o=-1);let i=v(GetOffsetFromEntityInWorldCoords(PlayerPedId(),(a.x+r.x)*o*n,(a.y+r.y)*n,a.z)),l=v(GetOffsetFromEntityInWorldCoords(PlayerPedId(),t.x,t.y,t.z)),s=CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA",i.x,i.y,i.z,0,0,0,49,!1,0);PointCamAtCoord(s,l.x,l.y,l.z),SetCamActiveWithInterp(s,m,1e3,1,1),h=!0;let c=setInterval(()=>{!IsCamInterpolating(m)&&IsCamActive(s)&&(DestroyCam(m,!1),m=s,h=!1,clearInterval(c))},500)}function D(e,a){H=!H;let t=OpenSequenceTask()??0;t!==0&&(TaskGoStraightToCoord(0,w.x,w.y,w.z,8,-1,GetEntityHeading(e)-a,.1),TaskStandStill(0,-1),CloseSequenceTask(t),ClearPedTasks(e),TaskPerformSequence(e,t),ClearSequenceTask(t))}async function Pe(e,a){let{animations:t,props:r}=q[a],{dict:o,anim:n,move:i,duration:l}=t.on,{male:s,female:c}=r,{components:d}=e,y=PlayerPedId(),p=g(y);for(RequestAnimDict(o);!HasAnimDictLoaded(o);)await x(0);if(p)for(let _=0;_<s.length;_++){let[f]=s[_];for(let P=0;P<d.length;P++){let{component_id:W,drawable:K,texture:J}=d[P];W===f&&SetPedComponentVariation(y,f,K,J,2)}}else for(let _=0;_<c.length;_++){let[f]=c[_];for(let P=0;P<d.length;P++){let{component_id:W,drawable:K,texture:J}=d[P];W===f&&SetPedComponentVariation(y,f,K,J,2)}}TaskPlayAnim(y,o,n,3,3,l,i,0,!1,!1,!1)}async function fe(e){let{animations:a,props:t}=q[e],{dict:r,anim:o,move:n,duration:i}=a.off,{male:l,female:s}=t,c=PlayerPedId(),d=g(c);for(RequestAnimDict(r);!HasAnimDictLoaded(r);)await x(0);if(d)for(let y=0;y<l.length;y++){let[p,_]=l[y];SetPedComponentVariation(c,p,_,0,2)}else for(let y=0;y<s.length;y++){let[p,_]=s[y];SetPedComponentVariation(c,p,_,0,2)}TaskPlayAnim(c,r,o,3,3,i,n,0,!1,!1,!1)}var oe=()=>He,R=(e,a)=>{He=a;let t=g(e);ClearPedDecorations(e);for(let r in a)for(let o=0;o<a[r].length;o++){let{collection:n,hashFemale:i,hashMale:l}=a[r][o],s=t?l:i;AddPedDecorationFromHashes(e,GetHashKey(n),GetHashKey(s))}},ge=(e,a)=>{let t=g(e);ClearPedDecorations(e);for(let r in a)for(let o=0;o<a[r].length;o++){let{collection:n,hashFemale:i,hashMale:l}=a[r][o],s=t?l:i;AddPedDecorationFromHashes(e,GetHashKey(n),GetHashKey(s))}},ve=(e,a)=>{let t=g(e);ClearPedDecorations(e);for(let r in a)for(let o=0;o<a[r].length;o++){let{collection:n,hashFemale:i,hashMale:l}=a[r][o],s=t?l:i;AddPedDecorationFromHashes(e,GetHashKey(n),GetHashKey(s))}},he=(e,a,t)=>{let r=g(e),{collection:o,hashFemale:n,hashMale:i}=t,l=r?i:n;ClearPedDecorations(e),AddPedDecorationFromHashes(e,GetHashKey(o),GetHashKey(l));for(let s in a)for(let c=0;c<a[s].length;c++){let{name:d,collection:y,hashFemale:p,hashMale:_}=a[s][c];if(t.name!==d){let f=r?_:p;AddPedDecorationFromHashes(e,GetHashKey(y),GetHashKey(f))}}};function Je(e,a=_e){let t=PlayerPedId();A=b(t),U=e,te=a,w=v(GetEntityCoords(t,!0)),$=GetEntityHeading(t),H=!1,h=!1,ae("default"),SetNuiFocus(!0,!0),SetNuiFocusKeepInput(!1),RenderScriptCams(!0,!1,0,!0,!0),DisplayRadar(!1),SetEntityInvincible(t,!0),TaskStandStill(t,-1);let r={type:"appearance_display",payload:{}};SendNuiMessage(JSON.stringify(r))}function Z(e){RenderScriptCams(!1,!1,0,!0,!0),DestroyCam(m,!1),DisplayRadar(!0),SetNuiFocus(!1,!1);let a=PlayerPedId();ClearPedTasksImmediately(a),SetEntityInvincible(a,!1);let t={type:"appearance_hide",payload:{}};if(SendNuiMessage(JSON.stringify(t)),!e)le(Q());else{let{tattoos:r}=e;R(a,r)}U&&U(e),U=null,te=null,A=null,w=null,m=null,I=null,H=null,h=null}function qe(e){e===GetCurrentResourceName()&&(SetNuiFocus(!1,!1),SetNuiFocusKeepInput(!1))}function Ye(){ue(),on("onResourceStop",qe),ze("startPlayerCustomization",Je)}var Me={loadModule:Ye};var u=global.exports,Ze="0x2746bd9d88c5c5d0",Ne="",Te="",Ae=[];on("updateJob",e=>{Ne=e});on("updateGang",e=>{Te=e});onNet("fivem-appearance:client:SetPlayerAces",e=>{Ae=e});function re(){return Ne}function ne(){return Te}function ie(){return Ae}var ke=JSON.parse(LoadResourceFile(GetCurrentResourceName(),"tattoos.json")),j=JSON.parse(LoadResourceFile(GetCurrentResourceName(),"peds.json")),E=JSON.parse(LoadResourceFile(GetCurrentResourceName(),"blacklist.json")),xe=JSON.parse(LoadResourceFile(GetCurrentResourceName(),"theme.json")),Ce=JSON.parse(LoadResourceFile(GetCurrentResourceName(),`locales/${GetConvar("fivem-appearance:locale","en")}.json`)),Ge=!1,we={};function $e(){for(let e=0;e<j.pedConfig.length;e++){let a=j.pedConfig[e].peds;for(let t=0;t<a.length;t++){let r=a[t];we[GetHashKey(r)]=r}}}function Ie(e){return Ge||($e(),Ge=!0),we[GetEntityModel(e)]}function Ee(e){let a=[];return O.forEach(t=>{a.push({component_id:t,drawable:GetPedDrawableVariation(e,t),texture:GetPedTextureVariation(e,t)})}),a}function Re(e){let a=[];return B.forEach(t=>{a.push({prop_id:t,drawable:GetPedPropIndex(e,t),texture:GetPedPropTextureIndex(e,t)})}),a}function Oe(e){let a=new ArrayBuffer(80);global.Citizen.invokeNative(Ze,e,new Uint32Array(a));let{0:t,2:r,4:o,6:n,8:i,10:l}=new Uint32Array(a),{0:s,2:c,4:d}=new Float32Array(a,48),y=parseFloat(s.toFixed(1)),p=parseFloat(c.toFixed(1)),_=parseFloat(d.toFixed(1));return Number.isNaN(_)&&(_=0),{shapeFirst:t,shapeSecond:r,shapeThird:o,skinFirst:n,skinSecond:i,skinThird:l,shapeMix:y,skinMix:p,thirdMix:_}}function Be(e){return F.reduce((t,r,o)=>{let n=parseFloat(GetPedFaceFeature(e,o).toFixed(1));return{...t,[r]:n}},{})}function De(e){return S.reduce((t,r,o)=>{let[,n,,i,l,s]=GetPedHeadOverlayData(e,o),c=n!==255,d=c?n:0,y=c?parseFloat(s.toFixed(1)):0,p;return r==="makeUp"?p={style:d,opacity:y,color:i,secondColor:l}:p={style:d,opacity:y,color:i},{...t,[r]:p}},{})}function Le(e){return{style:GetPedDrawableVariation(e,2),color:GetPedHairColor(e),highlight:GetPedHairHighlightColor(e),texture:GetPedTextureVariation(e,2)}}function b(e){let a=GetPedEyeColor(e);return{model:Ie(e)||"mp_m_freemode_01",headBlend:Oe(e),faceFeatures:Be(e),headOverlays:De(e),components:Ee(e),props:Re(e),hair:Le(e),eyeColor:a<de.length?a:0,tattoos:oe()}}async function L(e){if(!e||!IsModelInCdimage(e))return;for(RequestModel(e);!HasModelLoaded(e);)await x(0);SetPlayerModel(PlayerId(),e),SetModelAsNoLongerNeeded(e);let a=PlayerPedId();C(a)&&(SetPedDefaultComponentVariation(a),SetPedHeadBlendData(a,0,0,0,0,0,0,0,0,0,!1))}function M(e,a){if(!a)return;let{shapeFirst:t,shapeSecond:r,shapeThird:o,shapeMix:n,skinFirst:i,skinSecond:l,skinThird:s,skinMix:c,thirdMix:d}=a;C(e)&&SetPedHeadBlendData(e,t,r,o,i,l,s,n,c,d,!1)}function k(e,a){!a||F.forEach((t,r)=>{let o=a[t];SetPedFaceFeature(e,r,o)})}function G(e,a){!a||S.forEach((t,r)=>{let o=a[t];if(SetPedHeadOverlay(e,r,o.style,o.opacity),o.color||o.color===0){let i=1;var n=o.color;({blush:!0,lipstick:!0,makeUp:!0})[t]&&(i=2),t==="makeUp"&&(n=o.secondColor),SetPedHeadOverlayColor(e,r,i,o.color,n)}})}function N(e,a){if(!a)return;let{style:t,color:r,highlight:o,texture:n}=a;SetPedComponentVariation(e,2,t,n,2),SetPedHairColor(e,r,o)}function T(e,a){!a||SetPedEyeColor(e,a)}function z(e,a){if(!a)return;let{component_id:t,drawable:r,texture:o}=a;({0:!0,2:!0})[t]&&C(e)||SetPedComponentVariation(e,t,r,o,0)}function se(e,a){!a||a.forEach(t=>z(e,t))}function V(e,a){if(!a)return;let{prop_id:t,drawable:r,texture:o}=a;r===-1?ClearPedProp(e,t):SetPedPropIndex(e,t,r,o,!1)}function ce(e,a){!a||a.forEach(t=>V(e,t))}async function le(e){if(!e)return;let{model:a,components:t,props:r,headBlend:o,faceFeatures:n,headOverlays:i,hair:l,eyeColor:s,tattoos:c}=e;await L(a);let d=PlayerPedId();se(d,t),ce(d,r),o&&M(d,o),n&&k(d,n),i&&G(d,i),l&&N(d,l),s&&T(d,s),c&&R(d,c)}function Qe(e,a){if(!a)return;let{components:t,props:r,headBlend:o,faceFeatures:n,headOverlays:i,hair:l,eyeColor:s,tattoos:c}=a;se(e,t),ce(e,r),o&&M(e,o),n&&k(e,n),i&&G(e,i),l&&N(e,l),s&&T(e,s),c&&R(e,c)}function Xe(){Me.loadModule(),u("getPedModel",Ie),u("getPedComponents",Ee),u("getPedProps",Re),u("getPedHeadBlend",Oe),u("getPedFaceFeatures",Be),u("getPedHeadOverlays",De),u("getPedHair",Le),u("getPedTattoos",oe),u("getPedAppearance",b),u("setPlayerModel",L),u("setPedHeadBlend",M),u("setPedFaceFeatures",k),u("setPedHeadOverlays",G),u("setPedHair",N),u("setPedEyeColor",T),u("setPedComponent",z),u("setPedComponents",se),u("setPedProp",V),u("setPedProps",ce),u("setPedTattoos",R),u("setPlayerAppearance",le),u("setPedAppearance",Qe)}Xe();})();