<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
</section>

  <script>
  const iconContainer = document.querySelector('.common_section');
	iconContainer.addEventListener('click', (e) => {
    const active = document.querySelector('.home_contents.active');
    active.classList.remove('active');
    const target =  e.target;

    console.log(e.target);
    target.classList.add('active');
  });
  </script>
  
  <hr>
  <footer>
    <p>
      이용약관 | 개인정보 보호정책 | TEL 1588-0000, 080-000-0000 | FAX 02-000-0000 <br>
      본사 : 서울특별시 강남구 테헤란로 14길 6 남도빌딩 2F, 3F, 4F, 5F, 6F <br>
      Copyright©WEHUB All right reserved
    </p>
  </footer>
</body>
</html>