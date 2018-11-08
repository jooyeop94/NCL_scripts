;*************************************************
; NCL Graphics: X-Y plot for vegetation type
;************************************************
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl" 
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
;
; This file still has to be loaded manually
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"
;************************************************

begin

;************************************************
; What you need to modify
;************************************************
;1) file name a1=addfile (~~)
;2) calculate time ti
;3) res@trXMaxF = 150  ;maximum x
;
;************************************************
; read in netCDF file
;************************************************

 a1 = addfile("/home/jooyeop/CESMresult/eqtest_bare/run/eqtest_bare.clm2.hv.0002-01-01-00000.nc","r")
 a2 = addfile("/home/jooyeop/CESMresult/eqtest_bare/run/eqtest_bare.clm2.hv.0026-01-01-00000.nc","r")
 a3 = addfile("/home/jooyeop/CESMresult/eqtest_bare/run/eqtest_bare.clm2.hv.0050-01-01-00000.nc","r")
 a4 = addfile("/home/jooyeop/CESMresult/eqtest_bare/run/eqtest_bare.clm2.hv.0074-01-01-00000.nc","r")
 a5 = addfile("/home/jooyeop/CESMresult/eqtest_bare/run/eqtest_bare.clm2.hv.0098-01-01-00000.nc","r")
 a6 = addfile("/home/jooyeop/CESMresult/eqtest_bare/run/eqtest_bare.clm2.hv.0122-01-01-00000.nc","r")
 a7 = addfile("/home/jooyeop/CESMresult/eqtest_bare/run/eqtest_bare.clm2.hv.0146-01-01-00000.nc","r")
;************************************************
; read in data
;************************************************
 fpcgrid1_d = a1->FPCGRID
 fpcgrid2_d = a2->FPCGRID
 fpcgrid3_d = a3->FPCGRID
 fpcgrid4_d = a4->FPCGRID
 fpcgrid5_d = a5->FPCGRID
 fpcgrid6_d = a6->FPCGRID
 fpcgrid7_d = a7->FPCGRID
;************************************************
; find how many 0s(polar+a)  
;***********************************************
; countvar = 0
; do i=0,71
; do j=0,45
; if (.not.ismissing(fpcgrid1_d(0,0,j,i)).and.fpcgrid1_d(0,0,j,i).eq.0) then
; countvar = countvar + 1
; end if
; end do
; end do
; countvarmiss = 0
; do i=0,71
; do j=0,45
; if (.not.ismissing(fpcgrid1_d(0,0,j,i))) then
; countvarmiss = countvarmiss + 1
; end if
; end do
; end do
; print (countvar)
; print (countvarmiss)

;***********************************************
; calculation
;***********************************************
 fpcgrid1 = fpcgrid1_d(0,:,:,:)
 fpcgrid2 = fpcgrid2_d(0,:,:,:)
 fpcgrid3 = fpcgrid3_d(0,:,:,:)
 fpcgrid4 = fpcgrid4_d(0,:,:,:)
 fpcgrid5 = fpcgrid5_d(0,:,:,:)
 fpcgrid6 = fpcgrid6_d(0,:,:,:)
 fpcgrid7 = fpcgrid7_d(0,:,:,:)

fpcgrid_b=new( (/7/),double)	; _b : bare ground
fpcgrid_b@FillValue=1e+36
fpcgrid_b(0)=avg(fpcgrid1(0,:,:))
fpcgrid_b(1)=avg(fpcgrid2(0,:,:))
fpcgrid_b(2)=avg(fpcgrid3(0,:,:))
fpcgrid_b(3)=avg(fpcgrid4(0,:,:))
fpcgrid_b(4)=avg(fpcgrid5(0,:,:))
fpcgrid_b(5)=avg(fpcgrid6(0,:,:))
fpcgrid_b(6)=avg(fpcgrid7(0,:,:))
;print (fpcgrid_b(:))


fpcgrid_t=new( (/7/),double)	; _t : trees
fpcgrid_t@FillValue=1e+36
fpcgrid_t(0)=( avg(fpcgrid1(1,:,:))+avg(fpcgrid1(2,:,:))+avg(fpcgrid1(3,:,:))+avg(fpcgrid1(4,:,:))+avg(fpcgrid1(5,:,:))+avg(fpcgrid1(6,:,:))+avg(fpcgrid1(7,:,:))+avg(fpcgrid1(8,:,:)) )
fpcgrid_t(1)=( avg(fpcgrid2(1,:,:))+avg(fpcgrid2(2,:,:))+avg(fpcgrid2(3,:,:))+avg(fpcgrid2(4,:,:))+avg(fpcgrid2(5,:,:))+avg(fpcgrid2(6,:,:))+avg(fpcgrid2(7,:,:))+avg(fpcgrid2(8,:,:)) )
fpcgrid_t(2)=( avg(fpcgrid3(1,:,:))+avg(fpcgrid3(2,:,:))+avg(fpcgrid3(3,:,:))+avg(fpcgrid3(4,:,:))+avg(fpcgrid3(5,:,:))+avg(fpcgrid3(6,:,:))+avg(fpcgrid3(7,:,:))+avg(fpcgrid3(8,:,:)) )
fpcgrid_t(3)=( avg(fpcgrid4(1,:,:))+avg(fpcgrid4(2,:,:))+avg(fpcgrid4(3,:,:))+avg(fpcgrid4(4,:,:))+avg(fpcgrid4(5,:,:))+avg(fpcgrid4(6,:,:))+avg(fpcgrid4(7,:,:))+avg(fpcgrid4(8,:,:)) )
fpcgrid_t(4)=( avg(fpcgrid5(1,:,:))+avg(fpcgrid5(2,:,:))+avg(fpcgrid5(3,:,:))+avg(fpcgrid5(4,:,:))+avg(fpcgrid5(5,:,:))+avg(fpcgrid5(6,:,:))+avg(fpcgrid5(7,:,:))+avg(fpcgrid5(8,:,:)) )
fpcgrid_t(5)=( avg(fpcgrid6(1,:,:))+avg(fpcgrid6(2,:,:))+avg(fpcgrid6(3,:,:))+avg(fpcgrid6(4,:,:))+avg(fpcgrid6(5,:,:))+avg(fpcgrid6(6,:,:))+avg(fpcgrid6(7,:,:))+avg(fpcgrid6(8,:,:)) )
fpcgrid_t(6)=( avg(fpcgrid7(1,:,:))+avg(fpcgrid7(2,:,:))+avg(fpcgrid7(3,:,:))+avg(fpcgrid7(4,:,:))+avg(fpcgrid7(5,:,:))+avg(fpcgrid7(6,:,:))+avg(fpcgrid7(7,:,:))+avg(fpcgrid7(8,:,:)) )


fpcgrid_s=new( (/7/),double)	; _s : shrubs
fpcgrid_s@FillValue=1e+36
fpcgrid_s(0)=( avg(fpcgrid1(9,:,:))+avg(fpcgrid1(10,:,:))+avg(fpcgrid1(11,:,:)) )
fpcgrid_s(1)=( avg(fpcgrid2(9,:,:))+avg(fpcgrid2(10,:,:))+avg(fpcgrid2(11,:,:)) )
fpcgrid_s(2)=( avg(fpcgrid3(9,:,:))+avg(fpcgrid3(10,:,:))+avg(fpcgrid3(11,:,:)) )
fpcgrid_s(3)=( avg(fpcgrid4(9,:,:))+avg(fpcgrid4(10,:,:))+avg(fpcgrid4(11,:,:)) )
fpcgrid_s(4)=( avg(fpcgrid5(9,:,:))+avg(fpcgrid5(10,:,:))+avg(fpcgrid5(11,:,:)) )
fpcgrid_s(5)=( avg(fpcgrid6(9,:,:))+avg(fpcgrid6(10,:,:))+avg(fpcgrid6(11,:,:)) )
fpcgrid_s(6)=( avg(fpcgrid7(9,:,:))+avg(fpcgrid7(10,:,:))+avg(fpcgrid7(11,:,:)) )


fpcgrid_g=new( (/7/),double)	; _g : grass
fpcgrid_g@FillValue=1e+36
fpcgrid_g(0)=( avg(fpcgrid1(12,:,:))+avg(fpcgrid1(13,:,:))+avg(fpcgrid1(14,:,:)) )
fpcgrid_g(1)=( avg(fpcgrid2(12,:,:))+avg(fpcgrid2(13,:,:))+avg(fpcgrid2(14,:,:)) )
fpcgrid_g(2)=( avg(fpcgrid3(12,:,:))+avg(fpcgrid3(13,:,:))+avg(fpcgrid3(14,:,:)) )
fpcgrid_g(3)=( avg(fpcgrid4(12,:,:))+avg(fpcgrid4(13,:,:))+avg(fpcgrid4(14,:,:)) )
fpcgrid_g(4)=( avg(fpcgrid5(12,:,:))+avg(fpcgrid5(13,:,:))+avg(fpcgrid5(14,:,:)) )
fpcgrid_g(5)=( avg(fpcgrid6(12,:,:))+avg(fpcgrid6(13,:,:))+avg(fpcgrid6(14,:,:)) )
fpcgrid_g(6)=( avg(fpcgrid7(12,:,:))+avg(fpcgrid7(13,:,:))+avg(fpcgrid7(14,:,:)) )


;************************************************
; calculate time
;************************************************
 ti= new( (/7/),double)
 ti!0="time"

 ti(0)=1
 ti(1)=1+24
 ti(2)=1+24*2
 ti(3)=1+24*3
 ti(4)=1+24*4
 ti(5)=1+24*5
 ti(6)=1+24*6

 finaldata =new((/4,7/),double)
 finaldata(0,:)=fpcgrid_b(:)/1026.*1466 ; not count data like pole, they anyways have no data
 finaldata(1,:)=fpcgrid_t(:)/1026.*1466
 finaldata(2,:)=fpcgrid_s(:)/1026.*1466
 finaldata(3,:)=fpcgrid_g(:)/1026.*1466

print (finaldata(0,:))
;************************************************
; plot parameters
;************************************************
  wks = gsn_open_wks("x11","eq_test_bare")                ; send graphics to PNG file

  res                      = True                ; plot mods desired
 
 res@tiMainString    = "EXP_Bareground"   ;title

 res@trYMinF = 0	;minimum y
 res@trYMaxF = 100	;maximum y
 res@trXMinF = 0	;minimum x
 res@trXMaxF = 150	;maximum x
 res@tiXAxisString   = "Years"                        ; x-axis label
 res@tiYAxisString   = "Fraction (%)"                        ; y-axis label

 res@xyMarkLineModes = (/"Lines","Lines","Lines","Lines"/)
 res@xyDashPattern = (/"SolidLine"/)
 res@xyLineColors = (/"black","red","blue","green"/)
 res@xyLineThicknessF=2

  res@pmLegendDisplayMode    = "Always"            ; turn on legend
  res@pmLegendSide           = "Top"               ; Change location of 
  res@pmLegendParallelPosF   = .84                  ; move units right
  res@pmLegendOrthogonalPosF = -0.3                ; move units down
  res@pmLegendWidthF         = 0.1                ; Change width and
  res@pmLegendHeightF        = 0.1                ; height of legend.
  res@lgPerimOn              = True               ; turn off box around
  res@lgLabelFontHeightF     = .015                 ; label font height
  res@xyExplicitLegendLabels = (/"bareground","trees","shrubs","grass"/)         ; create explicit labels


;************************************************
; plot 
;************************************************
plot = gsn_csm_xy(wks,ti,finaldata,res)


end
