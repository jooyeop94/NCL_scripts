;************************************************
; NCL Graphics: Global map of plant type -  bareground
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
; read in netCDF file
;************************************************
 a = addfile("/home/jooyeop/CESMresult/eqtest_bare/run/eqtest_bare.clm2.hv.0101-01-01-00000.nc","r")
;************************************************
; read in data
;************************************************
 fpcgrid1 = a->FPCGRID
 fpcgrid = fpcgrid1(0,:,:,:)
 
 longi = a->longxy
 latit = a->latixy
 
 lon = longi(0,:)
; lat = latit(:,0)

 mlat = 46		; make latitude grid
 lat  = latGlobeF(mlat, "lat", "latitude", "degrees_east")

 fpcgrid@FillValue=1e+36
 lat@FillValue=1e+36
 lon@FillValue=1e+36

 fpcgrid!1="lat"
 fpcgrid!2="lon"
 fpcgrid&lat = lat
 fpcgrid&lon = lon
 fpcgrid&lat@units = "degrees_north"
 fpcgrid&lon@units = "degrees_east"


;************************************************
; plot parameters
;************************************************
  wks = gsn_open_wks("x11","eq_bare_bareground")                ; send graphics to PNG file

;  gsn_define_colormap(wks,"BlAqGrYeOrReVi200")
  cmap = read_colormap_file("BlAqGrYeOrReVi200") ; read color data


;  plot = new(4,graphic)
  res                      = True                ; plot mods desired

 res@tiMainString = "Bareground Fraction (EXP_Bareground)"
 
 res@gsnLeftString = "Plant functional type cover"
 res@gsnRightString = "Fraction of vegetated area (%)"

; res@cnFillMode            = "RasterFill"       ; raster plot
 res@cnFillMode            = "CellFill"       ; raster plot
 res@cnFillOn              = True               ; color on
 res@cnFillPalette         = cmap(11:170:0,:)  ; subselect color map and reverse it
;  res@lbLabelBarOn          = False              ; no label bar
  res@cnLinesOn             = False              ; no contour lines
  res@cnLineLabelsOn        = False             ; no line labels
;  res@cnLevelSpacingF       = 3.0 
;  res@mpOutlineBoundarySets = "AllBoundaries"   ; state and country boundaries
;  res@gsnDraw               = False             ; don't draw
;  res@gsnFrame              = False             ; don't advance frame
;************************************************
; plot one
;************************************************
  res@mpMinLatF            =  -89.               ; set min lat
  res@mpMaxLatF            =  89.                ; set max lat
  res@mpMinLonF            =  1.               ; set min lon
  res@mpMaxLonF            =  359.               ; set max lon
    res@mpCenterLonF     = 180                ; set map center at 180
  plot1=gsn_csm_contour_map_ce(wks,fpcgrid(0,:,:), res)   ; create plot
  
  end

