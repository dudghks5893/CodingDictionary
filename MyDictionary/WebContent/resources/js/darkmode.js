/**
 * 
 */

function darkMode() {
		if (document.querySelector('#night_day').value === '다크모드'){
		  document.querySelector('body').style.backgroundColor = '#161616';
		  document.querySelector('body').style.color = 'white';
		  document.querySelector('table').style.color = 'white';
		  document.querySelector('#night_day').value = '라이트모드';
		} else {
		  document.querySelector('body').style.backgroundColor = 'white';
		  document.querySelector('body').style.color = 'black';
		  document.querySelector('table').style.color = 'black';
		  document.querySelector('#night_day').value = '다크모드';
		}
	
}
