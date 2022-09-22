import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';

class GPAsystem extends StatelessWidget {
  const GPAsystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          BulletedList(
            style: TextStyle(
                // color: Colors.white,
                ),
            listItems: [
              '**With reference to the request for exemption from receiving the Corona vaccine. It\'s okay to do a weekly PCR swab.',
              'The effect of the academic warning (half-load) is cancelled if a student receives a cumulative rate of at least 2.',
              'The number of alarms is increased after each semester if the cumulative rate is less than 2.',
              'The school burden is reduced to 12 hours if a student receives a GPA of less than 2.0.',
              'A student is disqualified if he or she receives 4 separate academic alerts or three connected ones.',
              'Format requests, route switching, and special class are only made through the system and on scheduled dates; no paper requests are accepted.',
              'All students are required to register on the attached form as per the decision of the Vice Chancellor for Education and Student Affairs. Link',
              'All student complaints and applications must be submitted on an official "complaint form" to the complaints office of Muharram Bey. Oral requests or complaints on Whatsapp or by phone or any other means are ignored.',
              '** Student can register between 12-13 Credit Hours (Min) to 17 Credit Hours (Min).',
              '** A student with a cumulative average of 3 points or more and who has completed at least 33 credit hours may score 19 credits in the basic term.',
              '** A student will not be allowed to enroll in any course unless he or she meets the requirements prior to that course; a "fourth-level student" may be allowed to enrol in a course and previous requirement where he or she has "previously studied and failed" as an attendant.',
              '** The graduation requirements may record a student for 21 hours provided that the cumulative rate is not less than 3.',
            ],
            // bulletType: BulletType.numbered,
            bullet: Icon(
              Icons.circle,
              color: Colors.black,
              size: 13,
            ),
          ),
        ],
      ),
    );
  }
}
