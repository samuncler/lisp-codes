(in-package :TRAPS); Generated from QD3D.p; at Tuesday October 15,1996 4:05:36 pm.; ;  	File:		QD3D.p;  ;  	Contains:	Base types for QD3D							;  ;  	Version:	Technology:	Quickdraw 3D 1.0.6;  				Release:	Universal Interfaces 2.1.5d1;  ;  	Copyright:	� 1984-1996 by Apple Computer, Inc.  All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, send the file and version;  				information (from above) and the problem description to:;  ;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __QD3D__; $SETC __QD3D__ := 1; $I+; $SETC QD3DIncludes := UsingIncludes; $SETC UsingIncludes := 1; $IFC UNDEFINED __TYPES__(require-interface 'Types)                      ; $I Types.p; $ENDC; $PUSH; $ALIGN POWER; $LibExport+; ; *****************************************************************************;  **																			 **;  **								Porting Control								 **;  **																			 **;  ****************************************************************************; (defconstant $gestaltQD3D :|qd3d|)(defconstant $gestaltQD3DVersion :|q3v |)(defconstant $gestaltQD3DNotPresent 0)(defconstant $gestaltQD3DAvailable 1); ; *****************************************************************************;  **																			 **;  **								Export Control								 **;  **																			 **;  ****************************************************************************; ; ; *****************************************************************************;  **																			 **;  **								NULL definition								 **;  **																			 **;  ****************************************************************************; ; ; *****************************************************************************;  **																			 **;  **									Objects									 **;  **																			 **;  ****************************************************************************; ; ;  * Everything in QuickDraw 3D is an OBJECT: a bunch of data with a type,;  * deletion, duplication, and i/o methods.; (def-mactype :tq3objecttype (find-mactype ':ostype))(def-mactype :tq3object (find-mactype '(:pointer :signed-long))); ;  * There are four subclasses of OBJECT:;  *	an ELEMENT, which is data that is placed in a SET;  *	a SHAREDOBJECT, which is reference-counted data that is shared;  *	VIEWs, which maintain state information for an image;  *	a PICK, which used to query a VIEW; (def-mactype :tq3elementobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3sharedobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3viewobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3pickobject (find-mactype '(:pointer :signed-long))); ;  * There are several types of SharedObjects:;  *	RENDERERs, which paint to a drawContext;  *	DRAWCONTEXTs, which are an interface to a device ;  *	SETs, which maintains "mathematical sets" of ELEMENTs;  *	FILEs, which maintain state information for a metafile;  *	SHAPEs, which affect the state of the View;  *	SHAPEPARTs, which contain geometry-specific data about a picking hit;  *	CONTROLLERSTATEs, which hold state of the output channels for a CONTROLLER;  *	TRACKERs, which represent a position and orientation in the user interface;  *  STRINGs, which are abstractions of text string data.;  *	STORAGE, which is an abstraction for stream-based data storage (files, memory);  *	TEXTUREs, for sharing bitmap information for TEXTURESHADERS;  *	VIEWHINTs, which specifies viewing preferences in FILEs; (def-mactype :tq3rendererobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3drawcontextobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3setobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3fileobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3shapeobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3shapepartobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3controllerstateobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3trackerobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3stringobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3storageobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3textureobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3viewhintsobject (find-mactype '(:pointer :signed-long))); ;  * There is one types of SET:;  *	ATTRIBUTESETs, which contain ATTRIBUTEs which are inherited ; (def-mactype :tq3attributeset (find-mactype '(:pointer :signed-long)))(def-mactype :tq3attributesetptr (find-mactype '(:handle :signed-long))); ;  * There are many types of SHAPEs:;  *	LIGHTs, which affect how the RENDERER draws 3-D cues;  *	CAMERAs, which affects the location and orientation of the RENDERER in space;  *	GROUPs, which may contain any number of SHARED OBJECTS;  *	GEOMETRYs, which are representations of three-dimensional data;  *	SHADERs, which affect how colors are drawn on a geometry;  *	STYLEs, which affect how the RENDERER paints to the DRAWCONTEXT;  *	TRANSFORMs, which affect the coordinate system in the VIEW;  *	REFERENCEs, which are references to objects in FILEs;  *  UNKNOWN, which hold unknown objects read from a metafile.; (def-mactype :tq3groupobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3geometryobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3shaderobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3styleobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3transformobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3lightobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3cameraobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3unknownobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3referenceobject (find-mactype '(:pointer :signed-long))); ;  * For now, there is only one type of SHAPEPARTs:;  *	MESHPARTs, which describe some part of a mesh; (def-mactype :tq3meshpartobject (find-mactype '(:pointer :signed-long))); ;  * There are three types of MESHPARTs:;  *	MESHFACEPARTs, which describe a face of a mesh;  *	MESHEDGEPARTs, which describe a edge of a mesh;  *	MESHVERTEXPARTs, which describe a vertex of a mesh; (def-mactype :tq3meshfacepartobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3meshedgepartobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3meshvertexpartobject (find-mactype '(:pointer :signed-long))); ;  * A DISPLAY Group can be drawn to a view; (def-mactype :tq3displaygroupobject (find-mactype '(:pointer :signed-long))); ;  * There are many types of SHADERs:;  *	SURFACESHADERs, which affect how the surface of a geometry is painted;  *	ILLUMINATIONSHADERs, which affect how lights affect the color of a surface; (def-mactype :tq3surfaceshaderobject (find-mactype '(:pointer :signed-long)))(def-mactype :tq3illuminationshaderobject (find-mactype '(:pointer :signed-long))); ;  * A handle to an object in a group; (def-mactype :tq3groupposition (find-mactype '(:pointer :signed-long)))(def-mactype :tq3grouppositionptr (find-mactype '(:handle :signed-long))); ; *****************************************************************************;  **																			 **;  **							Client/Server Things							 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3controllerref (find-mactype ':pointer)); ; *****************************************************************************;  **																			 **;  **							Flags and Switches								 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3boolean (find-mactype ':signed-long)); TQ3Boolean(defconstant $kQ3False 0); TQ3Boolean(defconstant $kQ3True 1)(def-mactype :tq3switch (find-mactype ':signed-long)); TQ3Switch(defconstant $kQ3Off 0); TQ3Switch(defconstant $kQ3On 1)(def-mactype :tq3status (find-mactype ':signed-long)); TQ3Status(defconstant $kQ3Failure 0); TQ3Status(defconstant $kQ3Success 1)(def-mactype :tq3axis (find-mactype ':signed-long)); TQ3Axis(defconstant $kQ3AxisX 0); TQ3Axis(defconstant $kQ3AxisY 1); TQ3Axis(defconstant $kQ3AxisZ 2)(def-mactype :tq3pixeltype (find-mactype ':signed-long)); TQ3PixelType(defconstant $kQ3PixelTypeRGB32 0); TQ3PixelType(defconstant $kQ3PixelTypeRGB24 1); TQ3PixelType(defconstant $kQ3PixelTypeRGB16 2); TQ3PixelType(defconstant $kQ3PixelTypeRGB8 3)(def-mactype :tq3endian (find-mactype ':signed-long)); TQ3Endian(defconstant $kQ3EndianBig 0); TQ3Endian(defconstant $kQ3EndianLittle 1)(def-mactype :tq3endcapmasks (find-mactype ':signed-long)); TQ3EndCapMasks(defconstant $kQ3EndCapNone 0); TQ3EndCapMasks(defconstant $kQ3EndCapMaskTop #x1); TQ3EndCapMasks(defconstant $kQ3EndCapMaskBottom #x2)(def-mactype :tq3endcap (find-mactype ':signed-long)); ; *****************************************************************************;  **																			 **;  **						Point and Vector Definitions						 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3vector2dptr (find-mactype '(:pointer :tq3vector2d)))(defrecord TQ3Vector2D    (x :single-float)   (y :single-float)   )(def-mactype :tq3vector3dptr (find-mactype '(:pointer :tq3vector3d)))(defrecord TQ3Vector3D    (x :single-float)   (y :single-float)   (z :single-float)   )(def-mactype :tq3point2dptr (find-mactype '(:pointer :tq3point2d)))(defrecord TQ3Point2D    (x :single-float)   (y :single-float)   )(def-mactype :tq3point3dptr (find-mactype '(:pointer :tq3point3d)))(defrecord TQ3Point3D    (x :single-float)   (y :single-float)   (z :single-float)   )(def-mactype :tq3rationalpoint4dptr (find-mactype '(:pointer :tq3rationalpoint4d)))(defrecord TQ3RationalPoint4D    (x :single-float)   (y :single-float)   (z :single-float)   (w :single-float)   )(def-mactype :tq3rationalpoint3dptr (find-mactype '(:pointer :tq3rationalpoint3d)))(defrecord TQ3RationalPoint3D    (x :single-float)   (y :single-float)   (w :single-float)   ); ; *****************************************************************************;  **																			 **;  **								Quaternion									 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3quaternionptr (find-mactype '(:pointer :tq3quaternion)))(defrecord TQ3Quaternion    (w :single-float)   (x :single-float)   (y :single-float)   (z :single-float)   ); ; *****************************************************************************;  **																			 **;  **								Ray Definition								 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3ray3dptr (find-mactype '(:pointer :tq3ray3d)))(defrecord TQ3Ray3D    (origin :tq3point3d)   (direction :tq3vector3d)   ); ; *****************************************************************************;  **																			 **;  **						Parameterization Data Structures					 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3param2dptr (find-mactype '(:pointer :tq3param2d)))(defrecord TQ3Param2D    (u :single-float)   (v :single-float)   )(def-mactype :tq3param3dptr (find-mactype '(:pointer :tq3param3d)))(defrecord TQ3Param3D    (u :single-float)   (v :single-float)   (w :single-float)   )(def-mactype :tq3tangent2dptr (find-mactype '(:pointer :tq3tangent2d)))(defrecord TQ3Tangent2D    (uTangent :tq3vector3d)   (vTangent :tq3vector3d)   )(def-mactype :tq3tangent3dptr (find-mactype '(:pointer :tq3tangent3d)))(defrecord TQ3Tangent3D    (uTangent :tq3vector3d)   (vTangent :tq3vector3d)   (wTangent :tq3vector3d)   ); ; *****************************************************************************;  **																			 **;  **						Polar and Spherical Coordinates						 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3polarpointptr (find-mactype '(:pointer :tq3polarpoint)))(defrecord TQ3PolarPoint    (r :single-float)   (theta :single-float)   )(def-mactype :tq3sphericalpointptr (find-mactype '(:pointer :tq3sphericalpoint)))(defrecord TQ3SphericalPoint    (rho :single-float)   (theta :single-float)   (phi :single-float)   ); ; *****************************************************************************;  **																			 **;  **							Color Definition								 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3colorrgbptr (find-mactype '(:pointer :tq3colorrgb)))(defrecord TQ3ColorRGB    (r :single-float)   (g :single-float)   (b :single-float)   )(def-mactype :tq3colorargbptr (find-mactype '(:pointer :tq3colorargb)))(defrecord TQ3ColorARGB    (a :single-float)   (r :single-float)   (g :single-float)   (b :single-float)   ); ; *****************************************************************************;  **																			 **;  **									Vertices								 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3vertex3dptr (find-mactype '(:pointer :tq3vertex3d)))(defrecord TQ3Vertex3D    (point :tq3point3d)   (attributeSet (:pointer :signed-long))   ); ; *****************************************************************************;  **																			 **;  **									Matrices								 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3matrix3x3ptr (find-mactype '(:pointer :tq3matrix3x3)))(defrecord TQ3Matrix3x3    (value (:array :single-float 3 3))   )(def-mactype :tq3matrix4x4ptr (find-mactype '(:pointer :tq3matrix4x4)))(defrecord TQ3Matrix4x4    (value (:array :single-float 4 4))   ); ; *****************************************************************************;  **																			 **;  **								Bitmap/Pixmap								 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3pixmapptr (find-mactype '(:pointer :tq3pixmap)))(defrecord TQ3Pixmap    (image :pointer)   ;;Changing field width from signed-long to unsigned-long to match C header (pretty-darn-sure)   (width :unsigned-long)   ;;Changing field height from signed-long to unsigned-long to match C header (pretty-darn-sure)   (height :unsigned-long)   ;;Changing field rowbytes from signed-long to unsigned-long to match C header (pretty-darn-sure)   (rowBytes :unsigned-long)   ;;Changing field pixelsize from signed-long to unsigned-long to match C header (pretty-darn-sure)   (pixelSize :unsigned-long)   (pixelType :signed-long)   (bitOrder :signed-long)   (byteOrder :signed-long)   )(def-mactype :tq3storagepixmapptr (find-mactype '(:pointer :tq3storagepixmap)))(defrecord TQ3StoragePixmap    (image (:pointer :signed-long))   ;;Changing field width from signed-long to unsigned-long to match C header (pretty-darn-sure)   (width :unsigned-long)   ;;Changing field height from signed-long to unsigned-long to match C header (pretty-darn-sure)   (height :unsigned-long)   ;;Changing field rowbytes from signed-long to unsigned-long to match C header (pretty-darn-sure)   (rowBytes :unsigned-long)   ;;Changing field pixelsize from signed-long to unsigned-long to match C header (pretty-darn-sure)   (pixelSize :unsigned-long)   (pixelType :signed-long)   (bitOrder :signed-long)   (byteOrder :signed-long)   )(def-mactype :tq3bitmapptr (find-mactype '(:pointer :tq3bitmap)))(defrecord TQ3Bitmap    (image :pointer)   ;;Changing field width from signed-long to unsigned-long to match C header (pretty-darn-sure)   (width :unsigned-long)   ;;Changing field height from signed-long to unsigned-long to match C header (pretty-darn-sure)   (height :unsigned-long)   ;;Changing field rowbytes from signed-long to unsigned-long to match C header (pretty-darn-sure)   (rowBytes :unsigned-long)   (bitOrder :signed-long)   );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Bitmap_Empty" ((bitmap (:pointer :tq3bitmap)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Bitmap_GetImageSize" ((width :signed-long) (height :signed-long))   :signed-long   () ); ; *****************************************************************************;  **																			 **;  **						Higher dimension quantities							 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3areaptr (find-mactype '(:pointer :tq3area)))(defrecord TQ3Area    (min :tq3point2d)   (max :tq3point2d)   )(def-mactype :tq3planeequationptr (find-mactype '(:pointer :tq3planeequation)))(defrecord TQ3PlaneEquation    (normal :tq3vector3d)   (constant :single-float)   )(def-mactype :tq3boundingboxptr (find-mactype '(:pointer :tq3boundingbox)))(defrecord TQ3BoundingBox    (min :tq3point3d)   (max :tq3point3d)   (isEmpty :signed-long)   )(def-mactype :tq3boundingsphereptr (find-mactype '(:pointer :tq3boundingsphere)))(defrecord TQ3BoundingSphere    (origin :tq3point3d)   (radius :single-float)   (isEmpty :signed-long)   ); ;  *	The TQ3ComputeBounds flag passed to StartBoundingBox or StartBoundingSphere;  *	calls in the View. It's a hint to the system as to how it should ;  *	compute the bbox of a shape:;  *;  *	kQ3ComputeBoundsExact:	;  *		Vertices of shapes are transformed into world space and;  *		the world space bounding box is computed from them.  Slow!;  *	;  *	kQ3ComputeBoundsApproximate: ;  *		A local space bounding box is computed from a shape's;  *		vertices.  This bbox is then transformed into world space,;  *		and its bounding box is taken as the shape's approximate;  *		bbox.  Fast but the bbox is larger than optimal.; (def-mactype :tq3computebounds (find-mactype ':signed-long)); TQ3ComputeBounds(defconstant $kQ3ComputeBoundsExact 0); TQ3ComputeBounds(defconstant $kQ3ComputeBoundsApproximate 1); ; *****************************************************************************;  **																			 **;  **							Object System Types								 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3objectclass (find-mactype '(:pointer :signed-long)))(def-mactype :tq3methodtype (find-mactype ':signed-long)); ;  * Object methods; ; ;  * IO Methods; (def-mactype :tq3functionpointer (find-mactype ':pointer));  PROCEDURE TQ3FunctionPointer; C; (def-mactype :tq3metahandler (find-mactype ':pointer));  FUNCTION TQ3MetaHandler(methodType: TQ3MethodType): TQ3FunctionPointer; C; ; ;  * MetaHandler:;  *		When you give a metahandler to QuickDraw 3D, it is called multiple times to;  *		build method tables, and then is thrown away. You are guaranteed that;  *		your metahandler will never be called again after a call that was passed;  *		a metahandler returns.;  *;  *		Your metahandler should contain a switch on the methodType passed to it;  *		and should return the corresponding method as an TQ3FunctionPointer.;  *;  *		IMPORTANT: A metaHandler MUST always "return" a value. If you are;  *		passed a methodType that you do not understand, ALWAYS return NULL.;  *;  *		These types here are prototypes of how your functions should look.; (def-mactype :tq3objectunregistermethod (find-mactype ':pointer));  FUNCTION TQ3ObjectUnregisterMethod(objectClass: TQ3ObjectClass): TQ3Status; C; ; ;  * See QD3DIO.h for the IO method types: ;  *		ObjectReadData, ObjectTraverse, ObjectWrite; ; ; *****************************************************************************;  **																			 **;  **							Object System Macros							 **;  **																			 **;  ****************************************************************************; ; ; *****************************************************************************;  **																			 **;  **								Object Types								 **;  **																			 **;  ****************************************************************************; ; ;  * Note:	a call to Q3Foo_GetType will return a value kQ3FooTypeBar;  *			e.g. Q3Shared_GetType(object) returns kQ3SharedTypeShape, etc.; (defconstant $kQ3ObjectTypeInvalid 0)(defconstant $kQ3ObjectTypeView :|view|)(defconstant $kQ3ObjectTypeElement :|elmn|)(defconstant $kQ3ElementTypeAttribute :|eatt|)(defconstant $kQ3ObjectTypePick :|pick|)(defconstant $kQ3PickTypeWindowPoint :|pkwp|)(defconstant $kQ3PickTypeWindowRect :|pkwr|)(defconstant $kQ3ObjectTypeShared :|shrd|)(defconstant $kQ3SharedTypeRenderer :|rddr|)(defconstant $kQ3RendererTypeWireFrame :|wrfr|)(defconstant $kQ3RendererTypeGeneric :|gnrr|)(defconstant $kQ3RendererTypeInteractive :|ctwn|)(defconstant $kQ3SharedTypeShape :|shap|)(defconstant $kQ3ShapeTypeGeometry :|gmtr|)(defconstant $kQ3GeometryTypeBox :|box |)(defconstant $kQ3GeometryTypeGeneralPolygon :|gpgn|)(defconstant $kQ3GeometryTypeLine :|line|)(defconstant $kQ3GeometryTypeMarker :|mrkr|)(defconstant $kQ3GeometryTypeMesh :|mesh|)(defconstant $kQ3GeometryTypeNURBCurve :|nrbc|)(defconstant $kQ3GeometryTypeNURBPatch :|nrbp|)(defconstant $kQ3GeometryTypePoint :|pnt |)(defconstant $kQ3GeometryTypePolygon :|plyg|)(defconstant $kQ3GeometryTypePolyLine :|plyl|)(defconstant $kQ3GeometryTypeTriangle :|trng|)(defconstant $kQ3GeometryTypeTriGrid :|trig|)(defconstant $kQ3ShapeTypeShader :|shdr|)(defconstant $kQ3ShaderTypeSurface :|sush|)(defconstant $kQ3SurfaceShaderTypeTexture :|txsu|)(defconstant $kQ3ShaderTypeIllumination :|ilsh|)(defconstant $kQ3IlluminationTypePhong :|phil|)(defconstant $kQ3IlluminationTypeLambert :|lmil|)(defconstant $kQ3IlluminationTypeNULL :|nuil|)(defconstant $kQ3ShapeTypeStyle :|styl|)(defconstant $kQ3StyleTypeBackfacing :|bckf|)(defconstant $kQ3StyleTypeInterpolation :|intp|)(defconstant $kQ3StyleTypeFill :|fist|)(defconstant $kQ3StyleTypePickID :|pkid|)(defconstant $kQ3StyleTypeReceiveShadows :|rcsh|)(defconstant $kQ3StyleTypeHighlight :|high|)(defconstant $kQ3StyleTypeSubdivision :|sbdv|)(defconstant $kQ3StyleTypeOrientation :|ofdr|)(defconstant $kQ3StyleTypePickParts :|pkpt|)(defconstant $kQ3ShapeTypeTransform :|xfrm|)(defconstant $kQ3TransformTypeMatrix :|mtrx|)(defconstant $kQ3TransformTypeScale :|scal|)(defconstant $kQ3TransformTypeTranslate :|trns|)(defconstant $kQ3TransformTypeRotate :|rott|)(defconstant $kQ3TransformTypeRotateAboutPoint :|rtap|)(defconstant $kQ3TransformTypeRotateAboutAxis :|rtaa|)(defconstant $kQ3TransformTypeQuaternion :|qtrn|)(defconstant $kQ3ShapeTypeLight :|lght|)(defconstant $kQ3LightTypeAmbient :|ambn|)(defconstant $kQ3LightTypeDirectional :|drct|)(defconstant $kQ3LightTypePoint :|pntl|)(defconstant $kQ3LightTypeSpot :|spot|)(defconstant $kQ3ShapeTypeCamera :|cmra|)(defconstant $kQ3CameraTypeOrthographic :|orth|)(defconstant $kQ3CameraTypeViewPlane :|vwpl|)(defconstant $kQ3CameraTypeViewAngleAspect :|vana|)(defconstant $kQ3ShapeTypeGroup :|grup|)(defconstant $kQ3GroupTypeDisplay :|dspg|)(defconstant $kQ3DisplayGroupTypeOrdered :|ordg|)(defconstant $kQ3DisplayGroupTypeIOProxy :|iopx|)(defconstant $kQ3GroupTypeLight :|lghg|)(defconstant $kQ3GroupTypeInfo :|info|)(defconstant $kQ3ShapeTypeUnknown :|unkn|)(defconstant $kQ3UnknownTypeText :|uktx|)(defconstant $kQ3UnknownTypeBinary :|ukbn|)(defconstant $kQ3ShapeTypeReference :|rfrn|)(defconstant $kQ3SharedTypeSet :|set |)(defconstant $kQ3SetTypeAttribute :|attr|)(defconstant $kQ3SharedTypeDrawContext :|dctx|)(defconstant $kQ3DrawContextTypePixmap :|dpxp|)(defconstant $kQ3DrawContextTypeMacintosh :|dmac|)(defconstant $kQ3SharedTypeTexture :|txtr|)(defconstant $kQ3TextureTypePixmap :|txpm|)(defconstant $kQ3SharedTypeFile :|file|)(defconstant $kQ3SharedTypeStorage :|strg|)(defconstant $kQ3StorageTypeMemory :|mems|)(defconstant $kQ3MemoryStorageTypeHandle :|hndl|)(defconstant $kQ3StorageTypeUnix :|uxst|)(defconstant $kQ3UnixStorageTypePath :|unix|)(defconstant $kQ3StorageTypeMacintosh :|macn|)(defconstant $kQ3MacintoshStorageTypeFSSpec :|macp|)(defconstant $kQ3SharedTypeString :|strn|)(defconstant $kQ3StringTypeCString :|strc|)(defconstant $kQ3SharedTypeShapePart :|sprt|)(defconstant $kQ3ShapePartTypeMeshPart :|spmh|)(defconstant $kQ3MeshPartTypeMeshFacePart :|mfac|)(defconstant $kQ3MeshPartTypeMeshEdgePart :|medg|)(defconstant $kQ3MeshPartTypeMeshVertexPart :|mvtx|)(defconstant $kQ3SharedTypeControllerState :|ctst|)(defconstant $kQ3SharedTypeTracker :|trkr|)(defconstant $kQ3SharedTypeViewHints :|vwhn|)(defconstant $kQ3ObjectTypeEndGroup :|endg|); ; *****************************************************************************;  **																			 **;  **							QuickDraw 3D System Routines					 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3Initialize" ()   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Exit" ()   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3IsInitialized" ()   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3GetVersion" ((majorRevision (:pointer                                                 :signed-long)) (minorRevision (:pointer                                                                                :signed-long)))   :signed-long   () ); ; *****************************************************************************;  **																			 **;  **							ObjectClass Routines							 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ObjectClass_Unregister" ((objectClass (:pointer                                                           :signed-long)))   :signed-long   () ); ; *****************************************************************************;  **																			 **;  **								Object Routines								 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3Object_Dispose" ((object (:pointer :signed-long)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Object_Duplicate" ((object (:pointer :signed-long)))   (:pointer :signed-long)   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Object_Submit" ((object (:pointer                                             :signed-long)) (view (:pointer                                                                   :signed-long)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Object_IsDrawable" ((object (:pointer :signed-long)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Object_IsWritable" ((object (:pointer                                                 :signed-long)) (theFile (:pointer                                                                          :signed-long)))   :signed-long   () ); ; *****************************************************************************;  **																			 **;  **							Object Type Routines							 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3Object_GetType" ((object (:pointer :signed-long)))   :ostype   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Object_GetLeafType" ((object (:pointer :signed-long)))   :ostype   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Object_IsType" ((object (:pointer                                             :signed-long)) (theType :ostype))   :signed-long   () ); ; *****************************************************************************;  **																			 **;  **							Shared Object Routines							 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shared_GetType" ((sharedObject (:pointer :signed-long)))   :ostype   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shared_GetReference" ((sharedObject (:pointer                                                         :signed-long)))   (:pointer :signed-long)   () ); ; *****************************************************************************;  **																			 **;  **								Shape Routines								 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shape_GetType" ((shape (:pointer :signed-long)))   :ostype   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shape_GetSet" ((shape (:pointer                                           :signed-long)) (theSet (:pointer                                                                   (:pointer                                                                    :signed-long))))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shape_SetSet" ((shape (:pointer                                           :signed-long)) (theSet (:pointer                                                                   :signed-long)))   :signed-long   () ); $ALIGN RESET; $POP; $SETC UsingIncludes := QD3DIncludes; $ENDC                                         ; __QD3D__; $IFC NOT UsingIncludes; $ENDC(provide-interface 'QD3D)