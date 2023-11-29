import 'package:flutter/material.dart';


class DeleteCourseDialog extends StatelessWidget {
  final bool isWeb;
  final String subjectName, subjectId;
  final SubjectDetailsMainPageController controller;
  const DeleteSubjectDialog({
    Key? key,
    required this.controller,
    required this.subjectName,
    required this.subjectId,
    this.isWeb = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Card(
          child: Container(
            width: isWeb
                ? getScreenWidth(context) * .3
                : getScreenWidth(context) * .8,
            decoration: const BoxDecoration(),
            padding: AppTheme.margin20_10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppLocalizations.instance.translate('confirm.text'),
                  style: AppTheme.alertHeading,
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: AppLocalizations.instance
                        .translate('delete.subject.msg'),
                    style: AppTheme.textStyleNormal,
                    children: [
                      TextSpan(
                        text: ' "$subjectName" ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: '?'),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text(
                          AppLocalizations.instance.translate('cancel.text'),
                          style: AppTheme.pageButtonText
                              .copyWith(color: AppTheme.primaryColor),
                        ),
                        onPressed: controller.handleBackPressed,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppTheme.colorHotPinkAccent),
                        child: Text(
                          AppLocalizations.instance.translate('confirm.text'),
                          style: AppTheme.pageButtonText,
                        ),
                        onPressed: () => controller.handleSubjectDelete(
                            subjectId: subjectId),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
