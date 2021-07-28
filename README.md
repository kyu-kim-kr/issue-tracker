# Issue Tracker 팀 프로젝트

부트캠프 코드스쿼드의 마지막 협업 프로젝트로 깃헙 레포지토리 이슈 서비스를 만들어보는 프로젝트입니다. 

프론트엔드의 [@Autumn](https://github.com/dyongdi), [@Eamon](https://github.com/eamon3481) 백엔드의 [@Kyu](https://github.com/kyu-kim-kr), [@MJ](https://github.com/MJbae) iOS의 [@Issac](https://github.com/okstring)이 협업합니다.

- 💻 [웹 기획서](https://www.figma.com/proto/iOTGa5otAchVNyxqX6kjNI/FE_%EC%9D%B4%EC%8A%88%ED%8A%B8%EB%9E%98%EC%BB%A4?page-id=89%3A0&node-id=89%3A32&viewport=110%2C361%2C0.5&scaling=contain) | [웹 디자인](https://www.figma.com/file/iOTGa5otAchVNyxqX6kjNI/FE_%EC%9D%B4%EC%8A%88%ED%8A%B8%EB%9E%98%EC%BB%A4?node-id=32%3A243)
- 🍎 [iOS 기획서](https://www.figma.com/proto/qbGq144JknCEt25Sx1fxdb/iOS_%EC%9D%B4%EC%8A%88%ED%8A%B8%EB%9E%98%EC%BB%A4?page-id=122%3A3233&node-id=122%3A3239&viewport=-8430%2C178%2C0.5&scaling=contain) | [iOS 디자인](https://www.figma.com/file/qbGq144JknCEt25Sx1fxdb/iOS_%EC%9D%B4%EC%8A%88%ED%8A%B8%EB%9E%98%EC%BB%A4?node-id=87%3A314)
- 🔗 [팀 Wiki](https://github.com/kyupid/issue-tracker/wiki)

<br>

## 🎯 프로젝트 목표

### 공통
- github 의 issue 관리 프로그램 clone
- 온전히 유저와 연결된 CRUD 웹 서비스 완성하기

### 👨🏻‍💻 Backend
  - [API Docs](https://documenter.getpostman.com/view/12383029/TzeXjSg7)
  - Github OAuth 적용
  - 서버 배포를 위한 AWS EC2 인스턴스 사용
  - 이미지 업로드를 위한 AWS S3 사용
  - AWS VPC 이용 EC2, DB 서브넷 구분 생성
  - Ngnix와 톰캣을 연동해서 80포트만 개방
  - SQL 연습을 위해 JDBCTemplate 사용

### 💻 Frontend
- Github OAuth 적용
-  markdown parser 라이브러리 만들기
-  상태 관리 라이브러리 Recoil의 동작 익히기 (추후 myRecoil 구현해보기 위한 학습)
-  dev 브랜치 깔끔하게 관리하기
-  모르는 것 대충 넘어가지 않기
-  에러 처리 경험해보기

### 🍎 iOS

 - Github OAuth 로그인
 - UI/UX 부분 고민해보기
 - ML 관련 프레임워크 사용해보기
 - 유동적인 cell height 처럼 그냥 넘어가지 않고 해결해보기
 - image upload(AF - upload) 사용해보기
 - 혼자 하더라도 Issue, milestone 작성해가며 진행
 - Markdown 적용
 - 시간이 많이 걸리더라도 완성도를 높히기

<br>

## 🎊 구현 화면

### 💻 FE - [유튜브에서 확인하기 👀](https://youtu.be/HqTxYrGWDD8)

<br>

### 🍎 iOS

![issueTracker1](https://user-images.githubusercontent.com/62657991/124244476-f0980900-db59-11eb-9860-182b75ae84cf.gif)
![issueTracker2](https://user-images.githubusercontent.com/62657991/124244450-e970fb00-db59-11eb-9258-22753f813ad0.gif)

<br>


## 🏗 프로젝트의 전체적인 구조

BE: [ERD](https://user-images.githubusercontent.com/59721293/123792300-70846000-d91b-11eb-925d-6bec6eba8064.jpg)

FE: [Story&Task](https://github.com/kyu-kim-kr/issue-tracker/wiki/FE_-Story&Task)

iOS: [iOS Project kanban](https://github.com/kyu-kim-kr/issue-tracker/projects/2)

<br>

## 🎙 팀 rule

### 브랜치관리전략

[Git rule](https://github.com/kyu-kim-kr/issue-tracker/wiki/회의록#git-rule)

**프론트엔드의 브랜치 관리 전략**

1. dev-FE 브랜치는 한 사람이 커밋한 것처럼 관리한다.
2. 이를 위해 Pull Request merge 시 squash merge를 활용한다.
3. 작업 중인 feature 브랜치에서 dev 브랜치의 변경 사항을 반영해야 할 때는 적절히 rebase를 활용한다.


### 회의 시간

수업 없는 날: 아침 스크럼 끝나고 바로 (10시 반) 수업 있는 날: 오후 2시 눈치보면서👀 유동적으로

### 활동 기록 & 데일리 회고 
[🔗 데일리 회고 링크](https://github.com/kyu-kim-kr/issue-tracker/wiki/%5B1주차%5D-활동-기록-&-데일리-회고#0607-회고-월)

매일 개인이 회고를 HackMD에 작성하고 완성되면 Github wiki에 업로드한다




<br>


## 🛠 사용기술 및 환경

### 👨🏻‍💻 BE

AWS(EC2, VPC, S3),
Spring Boot,
JDBCtemplate,
Java,
MySQL

<br>

### 💻 FE

<img src="https://img.shields.io/badge/React-61DAFB?style=flat-square&logo=react&logoColor=white"/><span>&nbsp;&nbsp;</span>
<img src="https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=TypeScript&logoColor=white"/>
<span>&nbsp;&nbsp;</span>
<img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=JavaScript&logoColor=white"/>
<span>&nbsp;&nbsp;</span>
<img src="https://img.shields.io/badge/Recoil-764ABC?style=flat-square&logo=&logoColor=white"/>
<span>&nbsp;&nbsp;</span>
<img src="https://img.shields.io/badge/HTML5-E34F26?style=flat-square&logo=HTML5&logoColor=white"/>
<span>&nbsp;&nbsp;</span>
<img src="https://img.shields.io/badge/CSS3-1572B6?style=flat-square&logo=CSS3&logoColor=white"/>
<span>&nbsp;&nbsp;</span>
<img src="https://img.shields.io/badge/StyledComponent-A9225C?style=flat-square&logo=&logoColor=white"/>

<br>
<br>


### 🍎 iOS

[Octokit](https://github.com/nerdishbynature/octokit.swift)
<br>
[JWTDecode](https://github.com/auth0/JWTDecode.swift)
<br>
[MarkdownView](https://github.com/keitaoouchi/MarkdownView)
<br>
[NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)
<br>
[<img src="https://raw.githubusercontent.com/Alamofire/Alamofire/master/Resources/AlamofireLogo.png" width="300">](https://github.com/Alamofire/Alamofire)
[<img src="https://user-images.githubusercontent.com/62657991/122516186-6a53d100-d049-11eb-84f7-c36ee5757f9b.png" width="300">](https://github.com/airbnb/lottie-ios)

<br>



## Contribution

|name|posistion|GitHub URL|
|------|---|---|
|🙊 Eamon|`FE`|https://github.com/eamon3481|
|🐿 Autumn|`FE`|https://github.com/dyongdi|
|🐻 MJ|`BE`|https://github.com/MJbae|
|🐶 Kyu|`BE`|https://github.com/kyupid/|
|🐴 Issac|`iOS`|https://github.com/okstring|
