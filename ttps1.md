## 최초 침투 (Initial Access)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Valid Accounts** | 기존에 수집한 **유효한 계정 정보**를 이용하여 사내 홈페이지에 로그인합니다. |
| **Exploit Public-Facing Application** | 사내 홈페이지 게시판의 **파일 업로드 취약점**을 이용해 웹셸 파일(`view.asp`)을 업로드합니다. |

---

## 실행 (Execution)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Command-Line Interface** | 웹셸을 이용하여 그림 파일로 위장한 커스텀 CMD 프로그램(`info.jpg`)을 추가 다운로드하고 이를 명령 실행에 사용합니다. |
| **Scheduled Task** | 시스템 침투 후 **작업 스케줄러**에 악성코드를 등록하여 실행합니다 (`C:\Windows\Temp\taskhost.exe`). |
| **Service Execution** | 스케줄러를 통해 실행된 악성코드가 **추가 악성코드를 서비스로 등록** 후 실행합니다 (예: `Windows Helper Management Service`). |
| **Execution through API** | 악성코드가 명령조종지로부터 명령을 받아 `CreateProcessW`, `CreateProcessAsUserW` 등의 **API 함수를 호출**하여 추가 프로세스를 실행합니다. |
| **Execution through Module Load** | 서비스로 **DLL 형태의 악성코드**(`wmisrvmonsvc.dll`)를 로드하여 실행합니다. |

---

## 지속성 유지 (Persistence)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **New Service** | 악성코드를 **시스템 서비스로 등록**하여 재부팅 시마다 자동으로 실행되도록 설정합니다 (서비스 이름: `Windows Helper Management Service`). |
| **Redundant Access** | 악성코드 설치 후 웹 페이지에 **웹셸을 삽입**하여 추가적인 접근 통로를 확보하고 유지합니다. |
| **Valid Accounts** | 시스템 침입 후 획득한 계정을 이용하여 **지속적으로 로그인**을 시도합니다. |
| **Web Shell** | 기존에 삽입한 **웹셸에 접근**하여 서버 제어 권한을 유지합니다. |

---

## 권한 상승 (Privilege Escalation)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **New Service** | 악성코드를 **서비스로 실행**하여 **SYSTEM 권한**을 획득합니다 (이벤트 ID 7045). |
| **Web Shell** | 웹셸을 이용하여 확보한 웹 권한을 이용해 웹 기반의 악성 행위를 시도합니다. |
| **Exploitation for Privilege Escalation** | 권한 상승을 위해 오래된 Windows 환경 대상의 **폰트 파일 취약점** (CVE-2016-7256)을 사용합니다. |
| **Scheduled Task** | 관리자 권한을 획득한 후 **작업 스케줄러**에 악성코드를 등록하여 **시스템 권한**을 확보합니다. |

---

## 방어 회피 (Defense Evasion)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Indicator Removal on Host** | 호스트의 **시스템 로그를 삭제**하여 활동 감지와 정확한 분석을 어렵게 합니다 (이벤트 ID 104, 1102). |
| **Redundant Access** | 웹셸을 `vbscript.encode`로 **난독화**하거나, GIF 파일 헤더를 삽입하여 탐지를 회피합니다. |
| **File Deletion** | 악성코드를 이용하여 파일을 삭제한 후 **복구가 불가능하도록 덮어씁니다**. |
| **Obfuscated Files or Information** | 키로깅 악성코드가 수집한 정보를 **XOR 알고리즘으로 인코딩**하여 파일로 저장합니다. |
| **Masquerading** | 공격에 사용된 서비스 및 악성코드 명을 **정상적인 이름**으로 위장합니다 (예: `Windows Helper Management Service`). |
| **Process Injection** | 백신 탐지를 어렵게 하도록 `explorer.exe`와 같은 정상 프로세스에 **추가 악성코드를 인젝션**합니다. |
| **Web Shell** | 웹셸을 이용하여 확보한 웹 권한으로 웹 기반 악성 행위를 수행합니다. |

---

## 계정 정보 접근 (Credential Access)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Credential Dumping** | **PWDUMP**와 같은 패스워드 탈취 도구를 이용하여 침입한 시스템의 계정 정보를 수집합니다. |
| **Input Capture** | 시스템에 **키로깅 악성코드**를 설치하여 관리자 및 유저가 입력한 계정 정보를 수집합니다 (저장 경로: `C:\Windows\Temp\msvcrt000.xml`). |
| **Brute Force** | 수집한 계정 정보를 이용하여 다른 시스템에 **무작위로 로그인**을 시도합니다. |

---

## 탐색 (Discovery)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Account Discovery** | `net user`, `query user` 명령을 통해 로컬 시스템이나 도메인 계정 등의 **계정 정보**를 탐색합니다. |
| **Remote System Discovery** | `net view` 명령을 통해 네트워크 내 **다른 시스템**을 탐색합니다. |
| **System Information Discovery** | `systeminfo`, `hostname`, `ver` 명령을 통해 **시스템 기본 정보**를 탐색합니다. |
| **System Network Configuration Discovery** | `ipconfig /all`, `arp -a`, `appcmd.exe list site` 명령을 통해 **네트워크 구성 및 설정 정보**를 탐색합니다. |
| **System Network Connections Discovery** | `netstat -ano`, `query session` 명령을 통해 **네트워크 연결 상태 및 세션 정보**를 탐색합니다. |
| **System Service Discovery** | `sc query` 명령을 통해 시스템에 존재하는 **서비스 정보**를 탐색합니다. |
| **Find and Directory Discovery** | `dir` 명령 등을 통해 특정 경로의 **파일 및 폴더 정보**를 탐색합니다. |
| **Process Discovery** | `tasklist.exe` 명령을 통해 **프로세스 정보**를 탐색합니다. |
| **System Owner/User Discovery** | `whoami.exe` 명령을 통해 **시스템 소유자/유저 정보**를 탐색합니다. |
| **Application Window Discovery** | 키로거 악성코드를 통해 현재 **열려있는 프로그램 창 목록** (제목 표시줄)을 수집합니다. |

---

## 시스템 내부 이동 (Lateral Movement)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Windows Admin Shares** | `net use` 명령을 이용하여 **윈도우즈 기본 공유 기능** (Admin Shares)을 악용하여 원격 시스템에 로그인합니다. |
| **Remote File Copy** | 악성코드를 통해 공격자의 드라이브를 연결하여 **파일을 원격으로 복사**합니다. |

---

## 정보 수집 (Collection)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Data Staged** | 명령 수행 결과를 임시 파일 (`edg173F.tmp` 등)로 **저장**합니다. |
| **Input Capture** | 시스템에 키로깅 악성코드를 설치하여 **계정 정보**를 수집합니다. |
| **Data from Network Shared Drive** | 네트워크 공유 드라이브를 타깃 시스템에 연결하여 수집한 **데이터를 탈취**합니다. |

---

## 명령 제어 (Command and Control)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Commonly Used Port** | **HTTP (80 포트)** 프로토콜을 이용하여 명령제어 통신을 수행합니다. |
| **Standard Application Layer Protocol** | **HTTP**와 같은 표준 응용 프로토콜을 사용하여 명령제어를 수행합니다. |
| **Data Encoding** | 명령 문자열을 **Base64**로 인코딩하여 전송합니다. |
| **Standard Cryptographic Protocol** | 명령 문자열을 **RC4**와 같은 표준 암호화 알고리즘으로 암호화하여 통신합니다. |
| **Multi-Stage Channels** | 명령조종지 최초 접속 시 `config.dat` 파일에 저장된 **추가 공격자 서버**로 접속을 시도합니다. |
| **Remote File Copy** | 명령제어를 통해 추가 파일을 **생성 및 유출**합니다. |

---

## 정보 유출 (Exfiltration)

| 구분 | 공격 행위 요약 |
| :--- | :--- |
| **Data Compressed** | 악성코드 내부의 **Info-ZIP 라이브러리**를 이용하여 데이터를 압축하여 유출합니다 (`.zip` 파일). |
| **Data Transfer Size Limits** | 데이터 사이즈를 최대 약 **90KB**로 나누어서 전송 크기를 제한하며 유출합니다. |
| **Exfiltration Over Command and Control Channel** | **HTTP Query**를 이용하여 파일 생성, 삭제, 원격제어 및 정보 유출을 수행합니다 (예: `msgid=Saves&id=%llx&buffer=`). |