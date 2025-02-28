f1 = fullfile(which('Synthesis3J_3Finger'));
f2 = fullfile(which('pointStiff'));
f3 = fullfile(which('calcInt'));
f4 = fullfile(which('checkConditons'));
f5 = fullfile(which('checkSides'));
f6 = fullfile(which('Clear_string'));
f7 = fullfile(which('compOutputs'));
f8 = fullfile(which('connectJoints'));
f9 = fullfile(which('cTableResize'));
f10 = fullfile(which('dragPlot'));
f11 = fullfile(which('drawCircle'));
f12 = fullfile(which('drawLine'));
f13 = fullfile(which('drawPoint'));
f14 = fullfile(which('drawQuadCurve'));
f15 = fullfile(which('drawQuadCurve2'));
f16 = fullfile(which('fingerSynth'));
f17 = fullfile(which('goToPhase'));
f18 = fullfile(which('guide3J_3Finger'));
f19 = fullfile(which('guideCallback3J_3Finger'));
f20 = fullfile(which('MouseClick'));
f21 = fullfile(which('MouseDrag'));
f22 = fullfile(which('MouseRelease'));
f23 = fullfile(which('Outputs'));
f24 = fullfile(which('pointToLine'));
f25 = fullfile(which('storePointStiff'));
f26 = fullfile(which('UICallback3J_3Finger'));
f27 = fullfile(which('UpdateUI'));
f28 = fullfile(which('Visibility'));
f29 = fullfile(which('guide_message'));
f30 = fullfile(which('verticies'));
f31 = fullfile(which('getCurrentXY'));
f32 = fullfile(which('grabData'));
f33 = fullfile(which('perpIntersect'));
f34 = fullfile(which('PlanarCenter'));
f35 = fullfile(which('PlanarCnorm'));
f36 = fullfile(which('stiffnessCenter'));
f37 = fullfile(which('wrenchFromLine'));



compiler.build.standaloneApplication(f1, ...
    'AdditionalFiles', {f2, f3, f4, f5, f6, f7, f8, f9, f10, f11, f12, ...
    f13, f14, f15, f16, f17, f18, f19, f20, f21, f22, f23, f24, f25, ...
    f26, f27, f28, f29, f30, f31, f32, f33, f34, f35, f36, f37})