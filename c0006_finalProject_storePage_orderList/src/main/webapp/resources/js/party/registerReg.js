 function validate() {
        var test1 = /^[a-zA-Z0-9]{4,12}$/ // 아이디와 비번을 검사할 유효성검사식
        var test2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
        // 이메일이 적합한지 검사할 유효성검사식
 
        var id = $("#userId");
        var pw = $("#userPwdCheck");
         
        //====================================================이후 비교
 
        if (!check(test1, id)) {
			alert("아이디가 올바르지않습니다.");
            return false;
        } // 아이디 비교
 
//, "패스워드는 4~12자의 영문 대소문자와 숫자로만 입력"
        if (!check(test1, pw)) {
			alert("패스워드가 올바르지않습니다.")
            return false;
        } // 비번 비교
 
        if (join.upw.value != join.checkupw.value) {
            alert("비밀번호가 다릅니다. 다시 확인해 주세요.");
            join.checkupw.value = "";
            join.checkupw.focus();
            return false;
        } // 비번 확인
 
        if (email.value == "") {
            alert("이메일을 입력해 주세요");
            email.focus();
            return false;
        } // 이메일 입력 유무
 
        if (!check(test2, email)) {
			alert("이메일이 올바르지않습니다.")
            return false;
        } // 이메일 유효성검사식
    }
    //==================아이디, 비번, 이메일 비교
    function check(test1, what) {
        if (test1.test(what.value)) {
            return true;
        }
        alert(message);
        what.value = "";
        what.focus();
        //return false;
    }
