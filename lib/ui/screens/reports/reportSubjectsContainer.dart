import 'package:student/cubits/authCubit.dart';
import 'package:student/cubits/studentSubjectAndSlidersCubit.dart';
import 'package:student/data/models/subject.dart';
import 'package:student/ui/widgets/customBackButton.dart';
import 'package:student/ui/widgets/errorContainer.dart';
import 'package:student/ui/widgets/screenTopBackgroundContainer.dart';
import 'package:student/ui/widgets/shimmerLoaders/subjectsShimmerLoadingContainer.dart';
import 'package:student/ui/widgets/studentSubjectsContainer.dart';
import 'package:student/utils/labelKeys.dart';
import 'package:student/utils/uiUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportSubjectsContainer extends StatefulWidget {
  final int? childId;
  final List<Subject>? subjects;
  const ReportSubjectsContainer({Key? key, this.childId, this.subjects})
      : super(key: key);

  @override
  ReportSubjectsContainerState createState() => ReportSubjectsContainerState();

  static Route route(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments as Map<String, dynamic>;
    return CupertinoPageRoute(
      builder: (_) => ReportSubjectsContainer(
        childId: arguments['childId'],
        subjects: arguments['subjects'],
      ),
    );
  }
}

class ReportSubjectsContainerState extends State<ReportSubjectsContainer> {
  List<Subject>? subjects;

  @override
  void initState() {
    super.initState();
    if (widget.subjects != null) subjects = List.from(widget.subjects!);
  }

  Widget _buildAppBar() {
    return ScreenTopBackgroundContainer(
      padding: EdgeInsets.zero,
      heightPercentage: UiUtils.appBarSmallerHeightPercentage,
      child: Stack(
        children: [
          context.read<AuthCubit>().isParent()
              ? CustomBackButton(
                  topPadding: MediaQuery.of(context).padding.top +
                      UiUtils.appBarContentTopPadding,
                )
              : const SizedBox.shrink(),
          Align(
            child: Text(
              UiUtils.getTranslatedLabel(context, subjectsKey),
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontSize: UiUtils.screenTitleFontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMySubjects() {
    //remove blank subject entry [added for all assignment filter from previous screen]
    if (context.read<AuthCubit>().isParent() && subjects != null)
      subjects!.removeWhere((element) => element.id == 0);
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: UiUtils.getScrollViewTopPadding(
          context: context,
          appBarHeightPercentage: UiUtils.appBarSmallerHeightPercentage,
        ),
      ),
      child: (context.read<AuthCubit>().isParent())
          ? StudentSubjectsContainer(
              subjects: subjects!,
              subjectsTitleKey: '', //already shown in title
              childId: widget.childId,
              showReport: true,
            )
          : BlocBuilder<StudentSubjectsAndSlidersCubit,
              StudentSubjectsAndSlidersState>(
              builder: (context, state) {
                if (state is StudentSubjectsAndSlidersFetchSuccess) {
                  return StudentSubjectsContainer(
                    subjects: context
                        .read<StudentSubjectsAndSlidersCubit>()
                        .getSubjects(),
                    subjectsTitleKey: '', //already shown in title
                    childId: context.read<AuthCubit>().getStudentDetails().id,
                    showReport: true,
                  );
                }
                if (state is StudentSubjectsAndSlidersFetchFailure) {
                  return Center(
                    child: ErrorContainer(
                      errorMessageCode: state.errorMessage,
                      onTapRetry: () {
                        context
                            .read<StudentSubjectsAndSlidersCubit>()
                            .fetchSubjectsAndSliders();
                      },
                    ),
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.025),
                    ),
                    const SubjectsShimmerLoadingContainer(),
                  ],
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (context.read<AuthCubit>().isParent())
        ? Scaffold(
            body: Stack(
              children: [
                _buildMySubjects(),
                Align(
                  alignment: Alignment.topCenter,
                  child: _buildAppBar(),
                ),
              ],
            ),
          )
        : Stack(
            children: [
              _buildMySubjects(),
              Align(
                alignment: Alignment.topCenter,
                child: _buildAppBar(),
              ),
            ],
          );
  }
}
