import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:savemymoney/constants.dart';
import 'package:savemymoney/providers/expense_provider.dart';
import 'package:savemymoney/state/my_info_state.dart';
import 'package:savemymoney/theme.dart';
import 'package:savemymoney/uitls/extensions/inputExtensions.dart';
import 'package:savemymoney/widget/snack_bar.dart';

class ExpenseRegisterPage extends StatefulWidget {
  const ExpenseRegisterPage({Key? key}) : super(key: key);

  @override
  State<ExpenseRegisterPage> createState() => _ExpenseRegisterPageState();
}

class _ExpenseRegisterPageState extends State<ExpenseRegisterPage> {
  int _currentStep = 0;
  DateTime _date = DateTime.now();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('추가하기'),
      ),
      body: SingleChildScrollView(
        child: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: kPrimaryColor,
                  )),
          child: Stepper(
            currentStep: _currentStep,
            controlsBuilder: (context, details) {
              return Row(
                children: <Widget>[
                  Visibility(
                    visible: _currentStep != 0,
                    child: Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: details.onStepCancel,
                          child: const Text('이전'),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _currentStep == 2,
                    child: Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_titleController.text.isEmpty) {
                              showSnackBar(context, '제목을 확인해주세요.', () {});
                              return;
                            }
                            if (_titleController.text.isEmpty) {
                              showSnackBar(context, '제목을 확인해주세요.', () {});
                              return;
                            }
                            context.read<ExpenseProvider>().addData(
                                _date.toFormat1(),
                                _titleController.text,
                                _priceController.text);
                          },
                          child: const Text('저장'),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _currentStep != 2,
                    child: Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: details.onStepContinue,
                          child: const Text('다음'),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            onStepTapped: (index) {
              setState(() {
                _currentStep = index;
              });
            },
            onStepContinue: () {
              if (_currentStep != 2) {
                setState(() {
                  _currentStep++;
                });
              }
            },
            onStepCancel: () {
              if (_currentStep != 0) {
                setState(() {
                  _currentStep--;
                });
              }
            },
            steps: [
              Step(
                title: const Text('일자'),
                subtitle: const Text('일자를 선택해주세요.'),
                content: Container(
                  child: Column(
                    children: [
                      Text(
                        '날짜를 클릭하여 변경할 수 있습니다.',
                        style: textTheme().bodyText1,
                      ),
                      TextButton(
                        onPressed: () {
                          showDatePickerDialog((newDate) {
                            print('newDate : $newDate');
                            setState(() {
                              _date = newDate;
                            });
                          });
                        },
                        child: Text(_date.toFormat2()),
                      ),
                    ],
                  ),
                ),
                isActive: _currentStep >= 0,
              ),
              Step(
                title: const Text('제목'),
                subtitle: const Text('제목을 적어주세요'),
                content: Column(
                  children: [
                    Text(
                      '지출에 대한 간단한 제목을 남겨주세요.',
                      style: textTheme().bodyText1,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: '점심 값, 커피 내기 등등등!',
                          border: OutlineInputBorder(),
                        ))
                  ],
                ),
                isActive: _currentStep >= 1,
              ),
              Step(
                title: const Text('금액'),
                subtitle: const Text('지출 금액을 적어주세요.'),
                content: Column(
                  children: [
                    Text(
                      '지출 금액을 입력해주세요.',
                      style: textTheme().bodyText1,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: '숫자로 입력해주세요.',
                        border: OutlineInputBorder(),
                      ),
                      validator: (price) {
                        return price != null && price.isNotEmpty
                            ? null
                            : '숫자로만 입력해주세요';
                      },
                    )
                  ],
                ),
                isActive: _currentStep >= 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDatePickerDialog(Function callback) {
    DateTime today = DateTime.now();
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(today.year, today.month),
      lastDate: DateTime(today.year, today.month, today.day),
      currentDate: DateTime.now(),
    );

    selectedDate.then((dateTime) {
      callback(dateTime);
    });
  }
}
