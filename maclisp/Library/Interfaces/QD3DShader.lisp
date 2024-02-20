(in-package :TRAPS); Generated from QD3DShader.p; at Tuesday October 15,1996 4:10:19 pm.; ;  	File:		QD3DShader.p;  ;  	Contains:	QuickDraw 3D Shader / Color Routines							;  ;  	Version:	Technology:	Quickdraw 3D 1.0.6;  				Release:	Universal Interfaces 2.1.5d1;  ;  	Copyright:	� 1984-1996 by Apple Computer, Inc.  All rights reserved.;  ;  	Bugs?:		If you find a problem with this file, send the file and version;  				information (from above) and the problem description to:;  ;  					Internet:	apple.bugs@applelink.apple.com;  					AppleLink:	APPLE.BUGS;  ; #|                                              ; $IFC UNDEFINED UsingIncludes; $SETC UsingIncludes := 0 |#                                             ; $ENDC; $IFC NOT UsingIncludes; $ENDC; $IFC UNDEFINED __QD3DSHADER__; $SETC __QD3DSHADER__ := 1; $I+; $SETC QD3DShaderIncludes := UsingIncludes; $SETC UsingIncludes := 1#|                                              ; $IFC UNDEFINED __QD3D__|#(require-interface 'QD3D)#|                                              ; $I QD3D.p |#                                             ; $ENDC; $PUSH; $ALIGN POWER; $LibExport+; ; *****************************************************************************;  **																			 **;  **								RGB Color routines							 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorRGB_Set" ((color (:pointer                                           :tq3colorrgb)) (r :single-float) (g :single-float) (b :single-float))   (:pointer :tq3colorrgb)   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorARGB_Set" ((color (:pointer                                            :tq3colorargb)) (a :single-float) (r :single-float) (g :single-float) (b :single-float))   (:pointer :tq3colorargb)   () ); CONST                                         ; CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorRGB_Add" ((c1 (:pointer                                        :tq3colorrgb)) (c2 (:pointer                                                            :tq3colorrgb)) (result (:pointer                                                                                    :tq3colorrgb)))   (:pointer :tq3colorrgb)   () ); CONST                                         ; CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorRGB_Subtract" ((c1 (:pointer                                             :tq3colorrgb)) (c2 (:pointer                                                                 :tq3colorrgb)) (result (:pointer                                                                                         :tq3colorrgb)))   (:pointer :tq3colorrgb)   () ); CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorRGB_Scale" ((color (:pointer                                             :tq3colorrgb)) (scale :single-float) (result (:pointer                                                                                           :tq3colorrgb)))   (:pointer :tq3colorrgb)   () ); CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorRGB_Clamp" ((color (:pointer                                             :tq3colorrgb)) (result (:pointer                                                                     :tq3colorrgb)))   (:pointer :tq3colorrgb)   () ); CONST                                         ; CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorRGB_Lerp" ((first (:pointer                                            :tq3colorrgb)) (last (:pointer                                                                  :tq3colorrgb)) (alpha :single-float) (result (:pointer                                                                                                                :tq3colorrgb)))   (:pointer :tq3colorrgb)   () ); CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorRGB_Accumulate" ((src (:pointer                                                :tq3colorrgb)) (result (:pointer                                                                        :tq3colorrgb)))   (:pointer :tq3colorrgb)   () );   Q3ColorRGB_Luminance really returns a pointer to a Single ; CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3ColorRGB_Luminance" ((color (:pointer                                                 :tq3colorrgb)) (luminance (:pointer                                                                            :single-float)))   :pointer   () ); ; *****************************************************************************;  **																			 **;  **								Shader Types								 **;  **																			 **;  ****************************************************************************; (def-mactype :tq3shaderuvboundary (find-mactype ':signed-long)); TQ3ShaderUVBoundary(defconstant $kQ3ShaderUVBoundaryWrap 0); TQ3ShaderUVBoundary(defconstant $kQ3ShaderUVBoundaryClamp 1); ; *****************************************************************************;  **																			 **;  **								Shader Routines								 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shader_GetType" ((shader (:pointer :signed-long)))   :ostype   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shader_Submit" ((shader (:pointer                                             :signed-long)) (view (:pointer                                                                   :signed-long)))   :signed-long   () ); CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shader_SetUVTransform" ((shader (:pointer                                                     :signed-long)) (uvTransform (:pointer                                                                                  :tq3matrix3x3)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shader_GetUVTransform" ((shader (:pointer                                                     :signed-long)) (uvTransform (:pointer                                                                                  :tq3matrix3x3)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shader_SetUBoundary" ((shader (:pointer                                                   :signed-long)) (uBoundary :signed-long))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shader_SetVBoundary" ((shader (:pointer                                                   :signed-long)) (vBoundary :signed-long))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shader_GetUBoundary" ((shader (:pointer                                                   :signed-long)) (uBoundary (:pointer                                                                              :signed-long)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Shader_GetVBoundary" ((shader (:pointer                                                   :signed-long)) (vBoundary (:pointer                                                                              :signed-long)))   :signed-long   () ); ; *****************************************************************************;  **																			 **;  **							Illumination Shader	Classes						 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3IlluminationShader_GetType" ((shader (:pointer                                                          :signed-long)))   :ostype   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3PhongIllumination_New" ()   (:pointer :signed-long)   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3LambertIllumination_New" ()   (:pointer :signed-long)   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3NULLIllumination_New" ()   (:pointer :signed-long)   () ); ; *****************************************************************************;  **																			 **;  **		Texture Shader  - may use any type of Texture. (only 1 type in 1.0)	 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3TextureShader_New" ((texture (:pointer :signed-long)))   (:pointer :signed-long)   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3TextureShader_GetTexture" ((shader (:pointer                                                        :signed-long)) (texture (:pointer                                                                                 (:pointer                                                                                  :signed-long))))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3TextureShader_SetTexture" ((shader (:pointer                                                        :signed-long)) (texture (:pointer                                                                                 :signed-long)))   :signed-long   () ); ; *****************************************************************************;  **																			 **;  **		Texture Objects - For 1.0, there  is 1 subclass: PixmapTexture.		 **;  **		More subclasses will be added in later releases.					 **;  **			(e.g. PICTTexture, GIFTexture, MipMapTexture)					 **;  **																			 **;  ****************************************************************************; ;; Warning: No calling method defined for this trap(deftrap-inline "_Q3Texture_GetType" ((texture (:pointer :signed-long)))   :ostype   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Texture_GetWidth" ((texture (:pointer                                                 :signed-long)) (width (:pointer                                                                        :signed-long)))   :signed-long   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3Texture_GetHeight" ((texture (:pointer                                                  :signed-long)) (height (:pointer                                                                          :signed-long)))   :signed-long   () ); ; *****************************************************************************;  **																			 **;  **		Pixmap Texture													     **;  **			The TQ3StoragePixmap must contain a TQ3StorageObject that is a	 **;  **			Memory Storage ONLY for 1.0. We will support other storage 		 **;  **			classes in later releases.										 **;  **																			 **;  ****************************************************************************; ; CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3PixmapTexture_New" ((pixmap (:pointer :tq3storagepixmap)))   (:pointer :signed-long)   () );; Warning: No calling method defined for this trap(deftrap-inline "_Q3PixmapTexture_GetPixmap" ((texture (:pointer                                                        :signed-long)) (pixmap (:pointer                                                                                :tq3storagepixmap)))   :signed-long   () ); CONST;; Warning: No calling method defined for this trap(deftrap-inline "_Q3PixmapTexture_SetPixmap" ((texture (:pointer                                                        :signed-long)) (pixmap (:pointer                                                                                :tq3storagepixmap)))   :signed-long   () ); $ALIGN RESET; $POP; $SETC UsingIncludes := QD3DShaderIncludes; $ENDC                                         ; __QD3DSHADER__; $IFC NOT UsingIncludes; $ENDC(provide-interface 'QD3DShader)