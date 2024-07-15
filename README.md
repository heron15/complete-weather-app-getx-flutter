# Modern Weather App.

I developed this App mainly using the Java programming language. This app is the "MP Election app of Bangladesh". After entering the app, scan your National Digital ID card, select the area, and submit, the candidates in that area will automatically appear. Here, when the ID card is scanned and submitted, the ID card will be verified whether the user has voted before and whether his ID card is valid. Then the user can easily select the candidate of his choice and vote. Here is another option "Hide Me", if the user clicks on it and votes then no information will go to the admin. User's face verification will be done while voting.

An admin app has been created to control this voting application, within which the admin can add, edit, and delete districts and areas and add, edit, and delete candidates in that area. Admin app has another section View Results. Here admin can see how many votes the candidates got in that area by selecting the district and area. And the admin can easily see the details of the users who have voted for those candidates.

# The technology I used to develope this App.

<ol>
    <li>
        I used Google Firebase cloud text recognition service to convert text from an ID card. Collected Bengali and English text from NID card images through this firebase ML text recognition.
    </li>
    <li>
        I used the machine learning OpenCV library to process the image and clear it. So that the texts can be easily detected.
    </li>
    <li>
        I have used Google Firebase FireStore and Real-Time Database to save user data.
    </li>
    <li>
        I used the "fotoapparat" camera library to capture the image.
    </li>
    <li>
        Used Glide library to load images and SSP and SDP libraries to make the app responsive.
    </li>
    <li>
        Also I used the Volley library, to receive data from API.
    </li>
</ol>

## Screenshots

<div style="display:flex">
    <img src="https://media.licdn.com/dms/image/D5622AQFyzNzpCJ-2dw/feedshare-shrink_800/0/1701354011636?e=1723680000&v=beta&t=Lp0Hw-zmKbc7xVY7YIaAevHOMxBP7Lguf9r5hsOT9d8" alt="Home Screen" width="150" height="300" style="margin-right: 30px;">
    
</div>

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
